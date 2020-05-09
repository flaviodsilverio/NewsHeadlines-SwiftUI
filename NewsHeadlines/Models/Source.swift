//
//  Source.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 09/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

struct Source: Codable, Hashable, APIGetable {
	static var urlParameter: String {
		return String(describing: Source.self).pluralised()
	}

	var id: String?
	var name: String?
	var description: String?
	var category: String?
	var url: String?
	var language: String?
	var country: String?
}
