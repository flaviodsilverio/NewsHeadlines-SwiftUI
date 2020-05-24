//
//  HeadlineListViewModel.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation
import Combine

class HeadlineListViewModel: ObservableObject {
	@Published var headlines = [Headline]()

    let fetcher = Fetcher.shared

    var cancellables: [AnyCancellable] = []

	let requestClient = RequestClient(for: Headline.self)

	init() {
		getCombineData()
	}

	func getData() {
		requestClient.getData() { (response, error) in
			guard let headlines = response?.articles else { return }

			DispatchQueue.main.async {
				self.headlines = headlines
			}
		}
	}

    func getCombineData() {
        fetcher.fetch(requestWith: RequestBuilder.buildRequest(for: Headline.self)!)
        .mapError { error -> Error in
            return error
        }
        .sink(receiveCompletion: { _ in },
          receiveValue: { data in

            let object = Parser.parse(data)
            guard let headlines = object?.articles else { return }

            DispatchQueue.main.async {
                self.headlines = headlines
            }
            }).store(in: &cancellables)
    }
}

