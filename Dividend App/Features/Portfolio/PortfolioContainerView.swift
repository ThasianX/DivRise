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
    @State private var showingSortActions = false
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var body: some View {
        PortfolioView(showingDetail: $showingDetail, selectedIndex: $selectedIndex, showingSortActions: $showingSortActions, portfolioStocks: portfolioStocks, selectedSort: store.state.selectedSort)
            .onAppear(perform: reloadDividends)
            .sheet(isPresented: self.$showingDetail) {
                PortfolioDetailContainerView(portfolioStock: self.portfolioStocks[self.selectedIndex], selectedPeriod: self.store.state.selectedPeriod, attributeNames: self.store.state.attributeNames, show: self.$showingDetail)
                        .environmentObject(self.store)
//                PortfolioDetailContainerView(portfolioStock: PortfolioStock.sample[self.selectedIndex], selectedPeriod: self.store.state.selectedPeriod, attributeNames: self.store.state.attributeNames, show: self.$showingDetail)
//                    .environmentObject(self.store)
        }
        .actionSheet(isPresented: $showingSortActions) {
            ActionSheet(title: Text("Choose a sort for your portfolio stocks"), buttons: [sortBySymbol(), sortByName(), sortByStartingDiv(), sortByCurrentDiv(), sortByGrowth(), .cancel()])
        }
    }
    
    private func reloadDividends() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.store.send(.setSearchResults(results: []))
            self.store.send(updatePortfolio(portfolioStocks: self.portfolioStocks))
        }
    }
    
    private func sortBySymbol() -> ActionSheet.Button {
        .default(Text("Symbol ↑") , action: { self.store.send(.sortBySymbol) })
    }
    
    private func sortByName() -> ActionSheet.Button {
        .default(Text("Name ↑") , action: { self.store.send(.sortByName) })
    }
    
    private func sortByStartingDiv() -> ActionSheet.Button {
        .default(Text("Starting Dividend ↓") , action: { self.store.send(.sortByStartingDiv) })
    }
    
    private func sortByCurrentDiv() -> ActionSheet.Button {
        .default(Text("Current Dividend ↓") , action: { self.store.send(.sortByCurrentDiv) })
    }
    
    private func sortByGrowth() -> ActionSheet.Button {
        .default(Text("Growth ↓") , action: { self.store.send(.sortByGrowth) })
    }
}

