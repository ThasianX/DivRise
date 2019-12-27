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
    
    @State var dividendInput = ""
    @State var showingAdd = false
    
    private var monthlyRecords: [Record] {
        store.state.allMonthlyRecords
    }
    
    private var monthlyDividends: [Double] {
        store.state.allMonthlyDividends
    }
    
    var body: some View {
        TrackerView(monthlyRecords: monthlyRecords, monthlyDividends: monthlyDividends)
        .navigationBarTitle("tracker")
            .navigationBarItems(trailing: Button(action: {
                self.showingAdd = true
            }) { Text("add")})
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

struct AddDividendView: View {
    @Binding var input: String
    let onAdd: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Date().mediumStyle)
            Divider()
            HStack {
                Text("$")
                    .font(.system(size: 50))
                TextField("0.00", text: $input)
                    .font(.system(size: 50))
                    .keyboardType(.decimalPad)
            }
            Button(action: onAdd) {
                Text("add")
            }
        }
        .padding(40)
    }
}
