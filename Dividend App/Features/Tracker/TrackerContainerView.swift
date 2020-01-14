//
//  TrackerContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct TrackerContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @Binding var show: Bool
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    private var holdingsInfo: [HoldingInfo?] {
        store.state.portfolioStocks.map {
            store.state.allHoldingsInfo[$0]
        }
    }
    
    private var portfolioValue: Double {
        var total = 0.0
        let numShares = holdingsInfo.map { $0?.numOfShares }
        for (i, price) in store.state.currentSharePrices.enumerated() {
            if let num = numShares[i] {
                total += num * price
            }
        }
        return total
    }
    
    private var portfolioCostBasis: Double {
        return store.state.portfolioStocks.compactMap {
            store.state.allHoldingsInfo[$0]
        }
        .map { $0.avgCostPerShare * $0.numOfShares }
        .reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            TrackerView(portfolioStocks: portfolioStocks, holdingsInfo: holdingsInfo, currentSharePrices: store.state.currentSharePrices, portfolioValue: portfolioValue, portfolioCostBasis: portfolioCostBasis)
            .navigationBarTitle("Dividend Tracker")
            .navigationBarItems(trailing: ExitButton(show: $show))
            .onAppear(perform: getCurrentSharePrices)
        }
    }
    
    private func getCurrentSharePrices() {
        store.send(setCurrentSharePrices(portfolioStocks: portfolioStocks))
    }
}
