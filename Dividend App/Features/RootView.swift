//
//  RootView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import UserNotifications

struct RootView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
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
        .onAppear(perform: requestPermissions)
    }
    
    private func requestPermissions() { UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            Logger.info("Permission granted")
            if !self.store.state.notificationsSet {
                var component = DateComponents()
                component.day = 1
                component.hour = 10
                let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
                
                let content = UNMutableNotificationContent()
                content.title = "Input monthly dividend!"
                
                let id = UUID().uuidString
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if error != nil {
                        Logger.info("Couldn't set notification")
                    } else {
                        
                        DispatchQueue.main.async {
                            self.store.send(.toggleNotifications(enabled: true))
                            Logger.info("Notification set")
                        }
                    }
                }
            }
        } else if let error = error {
            Logger.info(error.localizedDescription)
            }
        }
        
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            switch settings.authorizationStatus {
            case .authorized:
                ()
                
            case .denied, .notDetermined, .provisional:
                DispatchQueue.main.async {
                    Logger.info("Denied")
                    self.store.send(.toggleNotifications(enabled: false))
                }
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
            @unknown default:
                ()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
