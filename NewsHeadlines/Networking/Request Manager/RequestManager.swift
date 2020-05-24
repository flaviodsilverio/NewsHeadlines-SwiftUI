//
//  RequestManager.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation
import Combine

enum RequestManagerError: Error {
	case invalidURLString
	case requestError
}

class Fetcher {
	static let shared = Fetcher()

	let session = URLSession(configuration: .default)

	typealias completionClosure = ((_ data: Data?,_ error: Error?)->())

    //Non-combine
	func fetch(requestWith string: String, completion: @escaping completionClosure) {
        guard let url = RequestBuilder.buildRequest(for: string) else { return }
		
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

    //Combine
    func fetch(requestWith url: URL) -> AnyPublisher<Data, APIError> {
        return URLSession.DataTaskPublisher(request: URLRequest(url: url), session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                return data
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(description: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(description: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

class RequestBuilder {
    static func buildRequest(for type: String) -> URL? {
        return URL(string: Constants.API.baseURL + "/" + type + "?country=us&apiKey=" + Constants.API.key)
    }

    static func buildRequest<T: APIGetable>(for type: T.Type) -> URL? {
        switch type {
        case is Headline.Type:
            return buildRequest(for: T.urlParameter)
        case is Source.Type:
            return buildRequest(for: T.urlParameter)
        default:
            return nil
        }
    }
}
