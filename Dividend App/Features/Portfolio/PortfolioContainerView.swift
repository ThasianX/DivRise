//
//  PortfolioContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var showingDetail = false
    @State private var bottomSheetShown = false
    @State private var selectedIndex = 0
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var body: some View {
        PortfolioView(showingDetail: $showingDetail, selectedIndex: $selectedIndex, portfolioStocks: portfolioStocks)
            .onAppear(perform: reloadDividends)
            .sheet(isPresented: self.$showingDetail) {
                PortfolioDetailContainerView(portfolioStock: self.portfolioStocks[self.selectedIndex], selectedPeriod: self.store.state.selectedPeriod, attributeNames: self.store.state.attributeNames, show: self.$showingDetail)
                    .environmentObject(self.store)
        }
    }
    
    private func reloadDividends() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.store.send(.setSearchResults(results: []))
            self.store.send(updatePortfolio(portfolioStocks: self.portfolioStocks))
        }
    }
}

