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
    @Published var isLoadingData = true
    @Published var isLoadingMore = false

    let fetcher = Fetcher.shared

    var cancellables: [AnyCancellable] = []
    var currentPage = 1

	init() {
        isLoadingData = true
		getData()
	}

    func getData() {
        fetcher.fetch(requestWith: RequestBuilder.buildRequest(for: Headline.self, page: currentPage)!)
        .mapError { error -> Error in
            return error
            }
        .sink(receiveCompletion: { _ in },
          receiveValue: { data in

            let object = Parser.parse(data)
            guard let headlines = object?.articles else { return }

            DispatchQueue.main.async {
                self.isLoadingData = false
                self.isLoadingMore = false
                self.headlines.append(contentsOf: headlines)
            }
            }).store(in: &cancellables)
    }

    func loadMoreData() {
        isLoadingMore = true
        currentPage += 1
        getData()
    }

    func hasShown(headline: Headline) {
        if self.headlines.firstIndex(of: headline) == headlines.count - 3 && !isLoadingData {
            loadMoreData()
        }
    }
}

