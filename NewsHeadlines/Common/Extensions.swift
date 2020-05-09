//
//  Extensions.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 08/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation

extension String {
	func pluralised() -> String {
		if self.last == "s" {
			return self
		} else {
			return self + "s"
		}
	}
}
