//
//  SourcesView.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 09/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import SwiftUI

class SourcesViewModel: ObservableObject {
	@Published var sources = [Source]()

	let requestClient = RequestClient(for: Source.self)

	init() {
		getData()
	}

	func getData() {
		requestClient.getData() { (response, error) in
			guard let sources = response?.sources else { return }

			DispatchQueue.main.async {
				self.sources = sources
			}
		}
	}
}

struct SourcesView: View {
	@ObservedObject var viewModel = SourcesViewModel()

	var body: some View {
		NavigationView {
			List(viewModel.sources, id:\.self) { source in
				Text(source.name!)
			}.navigationBarTitle("Sources")
		}
	}
}

class SourceViewModel {
	@Binding var isActive: Bool!

	var source: Source

	init?(from source: Source?) {
		guard let source = source else { return nil }

		isActive = true
		self.source = source
	}
}

struct SourceCell {
	private let imageView = Image.init(systemName: "m.circle.fill")
	let content: SourceViewModel

	var body : some View {
		VStack(alignment: .leading, spacing: 8.0) {
			HStack {
				imageView
				Text(content.source.name ?? "")
				Spacer()
				Toggle("", isOn: content.$isActive)
			}

		}
	}
}
