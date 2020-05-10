//
//  HeadlineDetailsView.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 04/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var cancellable: AnyCancellable?
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancellable?.cancel()
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @ObservedObject private var loader: ImageLoader
    private let placeholder: Placeholder?
	private var contentMode: ContentMode?

	init(url: URL,
		 placeholder: Placeholder? = nil,
		 contentMode: ContentMode? = .fill) {

        loader = ImageLoader(url: url)
        self.placeholder = placeholder
		self.contentMode = contentMode
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    private var image: some View {
		guard let image = loader.image else { return AnyView(placeholder) }

		return AnyView(
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: contentMode ?? .fill))

    }
}

struct HeadlineDetailsView: View {
	var content: Headline?

	var body: some View {
		VStack(spacing: 16) {
			Text(content?.title ?? "")
			Spacer()
				.frame(height: 20)
			AsyncImage(url: URL(string: content?.urlToImage! ?? "")!, placeholder: Text("Loading ..."))
			Text(content?.publishedAt ?? "")
			Text(content?.description ?? "")
			Spacer()
			Button(action: {

			}) {
				Text("Read Full Article")
					.frame(alignment: .trailing)

			}
			.frame(alignment: .trailing)

			Spacer().frame(height: 20)
		}
	}
}

struct HeadlineDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		HeadlineDetailsView(content: nil)
	}
}
