//
//  RequestClient.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

class RequestClient<T: APIGetable>: ObservableObject {
	let requestManager = RequestManager.shared
	var type: T.Type?

	@Published var responseData: APIResponse?

	init(for type: T.Type) {
		self.type = type
	}

	func getData(completion: @escaping ((_ apiResponse: APIResponse?, _ error: Error?)->())) {
		requestManager.perform(requestFor: T.urlParameter) { (data, error) in
			guard error == nil,
				let data = data else {
					print("error")
					return
			}

			do {
				let object = try JSONDecoder().decode(APIResponse.self, from: data)
				completion(object, nil)

			} catch {
				print(error)
			}

		}
	}
}
