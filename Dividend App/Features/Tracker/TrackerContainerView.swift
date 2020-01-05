//
//  TrackerContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct TrackerContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    @State private var dividendInput = ""
    @State private var showingAdd = false
    
    private var monthlyRecords: [Record] {
        store.state.allMonthlyRecords
    }
    
    private var monthlyDividends: [Double] {
        store.state.allMonthlyDividends
    }
    
    var body: some View {
        NavigationView {
            TrackerView(monthlyRecords: monthlyRecords, monthlyDividends: monthlyDividends)
                .navigationBarItems(trailing: Button(action: {
                    self.showingAdd = true
                }) { Image(systemName: "plus") })
                .sheet(isPresented: $showingAdd, onDismiss: { self.dividendInput = "" }) {
                    AddDividendView(input: self.$dividendInput, onAdd: self.addMonthlyDividend)
            }
            .navigationBarTitle(Text("Dividend Tracker"))
        }
        
    }
    
    private func addMonthlyDividend() {
        if let dividend = Double(dividendInput), dividend > 0 {
            showingAdd = false
            store.send(updateMonthlyDividends(dividend: dividend))
        }
    }
}

struct TrackerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        var appState = AppState()
        appState.allMonthlyRecords = []
        appState.allMonthlyDividends = []
        
        return TrackerContainerView().environmentObject(Store<AppState, AppAction>(initialState: appState, reducer: appReducer))
    }
}
