//
//  RootView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    init() {
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
//        UITabBar.appearance().backgroundColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            NavigationView {
                PortfolioContainerView()
            }
            .tabItem {
                Image(systemName: "tray.full.fill")
                Text("Portfolio")
            }
            
            NavigationView {
                TrackerContainerView()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Dividend Growth")
            }
            
            NavigationView {
                SettingsContainerView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
