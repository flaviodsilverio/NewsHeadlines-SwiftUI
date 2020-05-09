//
//  HeadlineListView.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 09/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import SwiftUI

//struct
struct HeadLinesView: View {
//	@ObservedObject var service = ArticleRequestClient()
	@ObservedObject var viewModel = HeadlinesViewModel()

//	@ObservedObject var headlines =
	//	@ObservedObject var requestClient = RequestClient(for: Source())

	var body: some View {
		NavigationView {
			List(viewModel.headlines, id:\.self) { article in
				VStack {
					NavigationLink(destination: HeadlineDetailsView(content: article)) {
						HeadlineCell(content: article)
					}
				}.frame(
					maxWidth: .infinity,
					maxHeight: .infinity,
					alignment: .topLeading
				)
					.background(Color.red)
			}.navigationBarTitle("Headlines")
		}
	}
}

struct HeadlineCell: View {
	private let imageView = Image.init(systemName: "m.circle.fill")
	let content: Headline

	var body : some View {
		VStack(alignment: .leading, spacing: 8.0) {
			Text(content.source?.name ?? "").background(Color.green)

			HStack {
				Text(content.title ?? "").lineLimit(5)
				Spacer()
				//				imageView.fixedSize(horizontal: true, vertical: true)
				//					.frame(width: 150, height: 150, alignment: .center)

			}

			Text(content.publishedAt ?? "").frame(width: .none, height: 20, alignment: .leading)
		}
	}
}


