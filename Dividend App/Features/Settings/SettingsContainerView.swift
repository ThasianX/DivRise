//
//  SettingsContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct SettingsContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var daySelection: Int = 0
    @State private var dateSelection: Date = Date()
    @State private var detailOrdering: [String] = []
    @State private var showDetailOrdering: Bool = false
    @Binding var show: Bool
    @Binding var receiveNotifications: Bool
    
    private var fullAttributeNames: [String] {
        store.state.attributeNames.compactMap {
            DetailAttributes.full[$0]
        }
    }
    
    var body: some View {
        NavigationView {
            SettingsView(receive: $receiveNotifications, daySelection: $daySelection, dateSelection: $dateSelection, showDetailOrdering: $showDetailOrdering, openSettings: openSettings, onNotificationChange: onNotificationChange)
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: ExitButton(show: self.$show))
                .onAppear(perform: onAppear)
                .sheet(isPresented: $showDetailOrdering) {
                    NavigationView {
                        DetailAttributeOrdering(showDetailOrdering: self.$showDetailOrdering, attributeOrder: self.$detailOrdering, fullAttributeNames: self.fullAttributeNames)
                            .onAppear(perform: { self.detailOrdering = self.store.state.attributeNames })
                            .environment(\.editMode, .constant(.active))
                            .navigationBarTitle("Detail Attribute Order")
                            .navigationBarItems(
                                leading: ExitButton(show: self.$showDetailOrdering),
                                trailing: CheckMarkButton(size: CGSize(width: 20, height: 20), action: self.onCommit)
                        )
                    }
                }
        }
    }
    
    private func onAppear() {
        daySelection = store.state.notificationDay
        dateSelection = store.state.notificationTime
    }
    
    private func onCommit() {
        self.showDetailOrdering = false
        self.store.send(.setAttributeNames(attributeNames: detailOrdering))
    }
    
    // Notification helpers
    private func openSettings() {
        if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: nil)
        }
    }
    
    private func onNotificationChange() {
        store.send(.setNotificationDay(day: daySelection))
        store.send(.setNotificationTime(time: dateSelection))
        setNotifications()
    }
    
    private func setNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        var component = DateComponents()
        component.day = self.store.state.notificationDay
        component.hour = self.store.state.notificationTime.getHour()
        component.minute = self.store.state.notificationTime.getMinute()
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
}

struct SettingsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainerView(show: .constant(true), receiveNotifications: .constant(true))
    }
}
