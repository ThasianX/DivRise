//
//  RootView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import UserNotifications

let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
let screen = UIScreen.main.bounds

struct RootView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State var show = false
    @State var showInfo = false
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = UIColor.gray
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            PortfolioContainerView()
                .blur(radius: show ? 20 : 0)
                .scaleEffect(showInfo ? 0.95 : 1)
                .animation(.default)
            
            PortfolioInfoContainerView()
                .frame(minWidth: 0, maxWidth: 712)
                .cornerRadius(30)
                .shadow(radius: 20)
                .animation(.spring())
                .offset(y: showInfo ? statusBarHeight + 40 : UIScreen.main.bounds.height)
            
            HStack {
                MenuButton(show: $show)
                    .offset(x: -40)
                Spacer()
                
                MenuRight(showInfo: $showInfo)
                    .environmentObject(self.store)
                    .offset(x: -16)
            }
            .offset(y: showInfo ? statusBarHeight : 80)
            .animation(.spring())
            
            MenuView(show: $show)
                .environmentObject(self.store)
        }
        .onAppear(perform: requestPermissions)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            Logger.info("Will enter foreground notification recieved")
            self.requestPermissions()
        }
    }
    
    private func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            Logger.info("Permission granted")
            self.setNotification()
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
    
    private func setNotification() {
        if !self.store.state.notificationsSet {
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
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        var appState = AppState()
        appState.portfolioStocks = ["AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL"]
        appState.allPortfolioStocks = ["AAPL": .mock]
        appState.searchResult = [.mock, .mock, .mock, .mock]
        
        return RootView()
            .environmentObject(Store<AppState, AppAction>(initialState: appState, reducer: appReducer))
    }
}

struct MenuRow: View {
    
    var image = ""
    var text = ""
    
    var body: some View {
        return HStack {
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(Color("icons"))
                .frame(width: 32, height: 32)
            
            Text(text)
                .font(.headline)
                .foregroundColor(Color("textColor"))
            
            Spacer()
        }
    }
}

struct Menu: Identifiable {
    var id = UUID()
    var title: String
    var icon: String
}

let menuData = [
    Menu(title: "My Portfolio", icon: "person.crop.circle"),
    Menu(title: "Dividend Tracker", icon: "chart.bar.fill"),
    Menu(title: "Settings", icon: "gear")
]

struct MenuView: View {
    var menu = menuData
    @EnvironmentObject var store: Store<AppState, AppAction>
    @Binding var show: Bool
    @State var showDividendTracker = false
    @State var showSettings = false
    
    var body: some View {
        return HStack {
            VStack(alignment: .leading) {
                ForEach(menu) { item in
                    if item.title == "Dividend Tracker" {
                        Button(action: { self.showDividendTracker.toggle() }) {
                            MenuRow(image: item.icon, text: item.title)
                                .sheet(isPresented: self.$showDividendTracker) {
                                    TrackerContainerView()
                                        .environmentObject(self.store)
                            }
                        }
                    } else if item.title == "Settings" {
                        Button(action: { self.showSettings.toggle() }) {
                            MenuRow(image: item.icon, text: item.title)
                                .sheet(isPresented: self.$showSettings) {
                                    SettingsContainerView(receive: self.store.state.notificationsSet, daySelection: self.store.state.notificationDay, dateSelection: self.store.state.notificationTime, show: self.$showSettings)
                                        .environmentObject(self.store)
                            }
                        }
                    } else {
                        MenuRow(image: item.icon, text: item.title)
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
            .padding(30)
            .frame(minWidth: 0, maxWidth: 360)
            .background(Color("button"))
            .cornerRadius(30)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
            .animation(.default)
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.show.toggle()
            }
            Spacer()
        }
        .padding(.top, statusBarHeight)
    }
}

struct CircleButton: View {
    var icon = "person.crop.circle"
    
    var body: some View {
        return HStack {
            Image(systemName: icon)
                .foregroundColor(Color("buttonColor"))
        }
        .frame(width: 44, height: 44)
        .background(Color("button"))
        .cornerRadius(30)
        .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
    }
}

struct MenuButton: View {
    @Binding var show: Bool
    
    var body: some View {
        return ZStack(alignment: .topLeading) {
            Button(action: { self.show.toggle() }) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "list.dash")
                        .foregroundColor(Color("buttonColor"))
                }
                .padding(.trailing, 18)
                .frame(width: 90, height: 60)
                .background(Color("button"))
                .cornerRadius(30)
                .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
            }
            Spacer()
        }
    }
}

struct MenuRight: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @Binding var showInfo: Bool
    @State var showSearch = false
    
    var body: some View {
        return ZStack(alignment: .topTrailing) {
            HStack {
                Button(action: {
                    self.showInfo.toggle()
                }) {
                    CircleButton(icon: "info.circle")
                }
                Button(action: { self.showSearch.toggle() }) {
                    CircleButton(icon: "magnifyingglass.circle")
                        .sheet(isPresented: self.$showSearch) {
                            AddStockContainerView()
                                .environmentObject(self.store)
                    }
                }
            }
            Spacer()
        }
    }
}
