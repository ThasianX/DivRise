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
        PortfolioView(showingDetail: $showingDetail, selectedIndex: $selectedIndex, showingSortActions: $showingSortActions, portfolioStocks: portfolioStocks, sortString: SortDirection.sortString(sort: store.state.selectedSort, direction: store.state.sortDirection))
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
        let name = (store.state.selectedSort == PortfolioSortState.symbol) ? Text("Symbol \(store.state.sortDirection)") : Text("Symbol")
        return .default(name, action: { self.store.send(.sortBy(sort: PortfolioSortState.symbol)) })
    }
    
    private func sortByName() -> ActionSheet.Button {
        let name = (store.state.selectedSort == PortfolioSortState.name) ? Text("Name \(store.state.sortDirection)") : Text("Name")
        return .default(name, action: { self.store.send(.sortBy(sort: PortfolioSortState.name)) })
    }
    
    private func sortByStartingDiv() -> ActionSheet.Button {
        let name = (store.state.selectedSort == PortfolioSortState.startingDiv) ? Text("Starting Dividend \(store.state.sortDirection)") : Text("Starting Dividend")
        return .default(name, action: { self.store.send(.sortBy(sort: PortfolioSortState.startingDiv)) })
    }
    
    private func sortByCurrentDiv() -> ActionSheet.Button {
        let name = (store.state.selectedSort == PortfolioSortState.currentDiv) ? Text("Current Dividend \(store.state.sortDirection)") : Text("Current Dividend")
        return .default(name, action: { self.store.send(.sortBy(sort: PortfolioSortState.currentDiv)) })
    }
    
    private func sortByGrowth() -> ActionSheet.Button {
        let name = (store.state.selectedSort == PortfolioSortState.growth) ? Text("Growth \(store.state.sortDirection)") : Text("Growth")
        return .default(name, action: { self.store.send(.sortBy(sort: PortfolioSortState.growth)) })
    }
}

