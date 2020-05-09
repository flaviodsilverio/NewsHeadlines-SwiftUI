//
//  RequestManager.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

enum RequestManagerError: Error {
	case invalidURLString
	case requestError
}

class RequestManager {
	static let shared = RequestManager(baseURL: Constants.API.baseURL)

	let session = URLSession(configuration: .default)
	private let baseURL: String

	typealias completionClosure = ((_ data: Data?,_ error: Error?)->())

    private init(baseURL: String) {
		self.baseURL = baseURL
    }

	func perform(requestFor string: String, completion: @escaping completionClosure) {
		guard let url = buildRequest(for: string) else { return }
		
		session.dataTask(with: url) { (data, response, error) in
			guard error == nil,
				let response = response as? HTTPURLResponse
				else {
					completion(nil, RequestManagerError.invalidURLString)
					return
			}

			switch response.statusCode {
			case 200..<300:
				completion(data, nil)
			default:
				completion(nil, RequestManagerError.requestError)
			}
		}.resume()
	}

	private func buildRequest(for type: String) -> URL? {
		return URL(string: baseURL + "/" + type + "?country=us&apiKey=" + Constants.API.key)
	}
}
