//
//  NavigationView.swift
//  NewsHeadlines
//
//  Created by Flavio Silverio on 09/05/2020.
//  Copyright © 2020 Flavio Silverio. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			HeadLinesView()
				.tabItem {
					Image(systemName: "phone.fill")
					Text("Headlines")
			}
			SourcesView()
				.tabItem {
					Image(systemName: "tv.fill")
					Text("Sources")
			}
			SettingsView()
				.tabItem {
					Image(systemName: "tv.fill")
					Text("Settings")
			}
		}

	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
