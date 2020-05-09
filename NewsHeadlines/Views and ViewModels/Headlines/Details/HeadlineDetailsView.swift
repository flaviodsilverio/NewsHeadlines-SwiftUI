//
//  HeadlineDetailsView.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 04/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import Foundation
import SwiftUI

struct HeadlineDetailsView: View {
    var content: Headline?

	var body: some View {
		Text("Sources")
	}
}

struct HeadlineDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		HeadlineDetailsView(content: nil)
	}
}
