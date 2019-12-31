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
        TrackerView(monthlyRecords: monthlyRecords, monthlyDividends: monthlyDividends)
        .navigationBarTitle("Dividend Growth")
            .navigationBarItems(trailing: Button(action: {
                self.showingAdd = true
            }) { Text("Add")})
            .sheet(isPresented: $showingAdd, onDismiss: { self.dividendInput = "" }) {
                AddDividendView(input: self.$dividendInput, onAdd: self.addMonthlyDividend)
        }
    }
    
    private func addMonthlyDividend() {
        if let dividend = Double(dividendInput) {
            showingAdd = false
            store.send(updateMonthlyDividends(dividend: dividend))
        }
    }
}


