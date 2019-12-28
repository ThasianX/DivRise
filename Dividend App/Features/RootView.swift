//
//  RootView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationView {
                PortfolioContainerView()
            }
            .tabItem {
                Image(systemName: "tray.full.fill")
                Text("portfolio")
            }
            
            NavigationView {
                TrackerContainerView()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("tracker")
            }
            
            NavigationView {
                SettingsContainerView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("settings")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
