//
//  Headline.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 09/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

struct Headline: Codable, Hashable, APIGetable {
	static var urlParameter: String {
		return "top-" + String(describing: Headline.self).pluralised()
	}

	var author: String?
	var title: String?
	var description: String?
	var url: String?
	var urlToImage: String?
	var publishedAt: String?
	var content: String?
	var source: Source?

}
