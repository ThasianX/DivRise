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
    
    @State var receive: Bool
    @State var daySelection: Int
    @State var dateSelection: Date
    
    @Binding var show: Bool
    
    init(receive: Bool, daySelection: Int, dateSelection: Date, show: Binding<Bool>) {
        _receive = State(initialValue: receive)
        _daySelection = State(initialValue: daySelection)
        _dateSelection = State(initialValue: dateSelection)
        self._show = show
    }
    
    var body: some View {
        NavigationView {
            SettingsView(receive: $receive, daySelection: $daySelection, dateSelection: $dateSelection, openSettings: openSettings, onNotificationChange: onNotificationChange)
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing:
                    Button(action: {
                    self.show = false
                }) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.gray)
                }
                .buttonStyle(PlainButtonStyle())
            )
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        self.receive = self.store.state.notificationsSet
                    }
                }
        }
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
        SettingsContainerView(receive: false, daySelection: 10, dateSelection: Date().dateAtTime(hour: 2, minute: 2), show: .constant(true))
    }
}
