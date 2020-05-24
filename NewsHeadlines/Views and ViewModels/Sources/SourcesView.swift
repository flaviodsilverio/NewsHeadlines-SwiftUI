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

            sources.forEach { source in
                guard let id = source.id else { return }

                TemporarySourceManager.shared.activeSources.append(id)
            }

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
				SourceCell(content: SourceViewModel(from: source)!)
			}.navigationBarTitle("Sources")
		}
	}
}

class SourceViewModel: ObservableObject {
	@Published var isActive: Bool = false

	var source: Source

	init?(from source: Source?) {
		guard let source = source else { return nil }

		isActive = true
		self.source = source
	}

	func didTapToggle() {
		isActive = !isActive
	}
}

struct SourceCell: View {
	private let imageView = Image.init(systemName: "m.circle.fill")
	@ObservedObject var content: SourceViewModel

	var body : some View {
		VStack(alignment: .leading, spacing: 8.0) {
			HStack {
				imageView
				Toggle(isOn: $content.isActive) {
					Text(content.source.name ?? "")
				}.onTapGesture {
					self.content.didTapToggle()

				}
			}
		}
	}
}
