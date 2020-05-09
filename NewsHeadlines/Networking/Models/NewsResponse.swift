//
//  NewsResponse.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 26/04/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
	var status: String
	var totalResults: Int?
	var articles: [Headline]?
	var sources: [Source]?
}


