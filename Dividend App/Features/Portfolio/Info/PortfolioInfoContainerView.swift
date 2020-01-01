//
//  PortfolioInfoContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/31/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioInfoContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var startingDividend: String = ""
    @State private var selectedIndex: Int = 0
    @State private var formShown: Bool = false
    
    let portfolioStocks: [PortfolioStock]
    let upcomingDividendDates: [Date]
    
    var body: some View {
        PortfolioInfoView(selectedIndex: $selectedIndex, formShown: $formShown, portfolioStocks: portfolioStocks, upcomingDates: upcomingDividendDates)
            .sheet(isPresented: $formShown, onDismiss: {
                self.startingDividend = ""
            }) {
                Form {
                    Section(header: Text("Starting Dividend").font(.system(size: 20))) {
                        HStack {
                            if !self.startingDividend.isEmpty {
                                Text("$")
                                    .font(.system(size: 50))
                            }
                            TextField("$\(self.portfolioStocks[self.selectedIndex].startingDividend, specifier: "%.2f")", text: self.$startingDividend)
                                .keyboardType(.decimalPad)
                                .font(.system(size: 50))
                        }
                        
                    }
                    
                    Section {
                        Button(action: {
                            withAnimation {
                                self.onUpdate()
                            }
                        }) {
                            Text("Update")
                                .foregroundColor(.green)
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.formShown.toggle()
                            }
                        }) {
                            Text("Cancel")
                                .foregroundColor(.red)
                        }
                    }
                }
        }
    }
    
    private func onUpdate() {
        if let val = Double(startingDividend) {
            store.send(.updateStartingDividend(double: val, index: selectedIndex))
            formShown.toggle()
        }
    }
}
