//
//  HeadlinesViewModel.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

class HeadlinesViewModel: ObservableObject {
	@Published var headlines = [Headline]()

	let requestClient = RequestClient(for: Headline.self)

	init() {
		getData()
	}

	func getData() {
		requestClient.getData() { (response, error) in
			guard let headlines = response?.articles else { return }

			DispatchQueue.main.async {
				self.headlines = headlines
			}
		}
	}
}
