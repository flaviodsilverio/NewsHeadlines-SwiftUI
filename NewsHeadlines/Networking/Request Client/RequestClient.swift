//
//  RequestClient.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation
import Combine

class RequestClient<T: APIGetable>: ObservableObject {
	let fetcher = Fetcher.shared
	var type: T.Type?

	@Published var responseData: APIResponse?

    var test: AnyCancellable?

	init(for type: T.Type) {
		self.type = type
	}

    //Non-Combine
	func getData(completion: @escaping ((_ apiResponse: APIResponse?, _ error: Error?)->())) {
		fetcher.fetch(requestWith: T.urlParameter) { (data, error) in
			guard error == nil,
				let data = data,
                let parsedData = Parser.parse(data) else {
					completion(nil, error)
					return
			}
            completion(parsedData, nil)
		}
	}
        //Combine
        func getData() {
            guard let urlString = RequestBuilder.buildRequest(for: T.urlParameter) else { return }
            test = fetcher.fetch(requestWith: urlString)
                .mapError { error -> Error in
                    return error
                }
                .sink(receiveCompletion: { _ in },
                  receiveValue: { data in

                    let object = Parser.parse(data)
                    self.responseData = object
                })
        }
    }

    class Parser {
        static func parse(_ data: Data) -> APIResponse? {
            do {
                let object = try JSONDecoder().decode(APIResponse.self, from: data)
                return object

            } catch {
                return nil
            }
        }
    }
