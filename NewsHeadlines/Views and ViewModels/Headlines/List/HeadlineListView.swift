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
            if viewModel.isLoadingData {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            } else {
                VStack {

                    List(viewModel.headlines, id:\.self) { headline in
                        VStack {
                            NavigationLink(destination: HeadlineDetailsView(content: headline)) {
                                HeadlineCell(content: headline).onAppear {
                                    self.viewModel.hasShown(headline: headline)
                                }
                            }
                        }.frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                    }
                    if self.viewModel.isLoadingMore {
                        ActivityIndicator(isAnimating: .constant(true), style: .medium)
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


