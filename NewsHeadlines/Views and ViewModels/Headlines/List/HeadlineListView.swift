//
//  HeadlineListView.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 09/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import SwiftUI

enum HeadlineStyle {
	case text
	case detail
}

struct HeadLinesView: View {
	@ObservedObject var viewModel = HeadlineListViewModel()
	@State private var uiStyle: HeadlineStyle = .text

	var body: some View {
		NavigationView {
			VStack {
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
				}

				  Picker("Numbers", selection: $uiStyle) {
					Text("text").tag(2)
					Text("detail").tag(1)
				  }
				  .pickerStyle(SegmentedPickerStyle())
			}

			.navigationBarTitle("Headlines")
		}
	}
}

struct HeadlineCell: View {
	private let imageView = Image(systemName: "m.circle.fill")
	let content: Headline

	var body : some View {
		VStack(alignment: .leading, spacing: 8.0) {
			Text(content.source?.name ?? "").background(Color.green)

			HStack {
				Text(content.title ?? "").lineLimit(5)
			}

			Text(content.publishedAt ?? "").frame(width: .none, height: 20, alignment: .leading)
		}
	}
}


