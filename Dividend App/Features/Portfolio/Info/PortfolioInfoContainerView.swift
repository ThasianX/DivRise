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
    
    @State private var showEditInfo: Bool = false
    @State private var selectedIndex: Int = 0
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    private var upcomingDividendDates: [Date] {
        store.state.portfolioStocks.compactMap {
            store.state.allUpcomingDivDates[$0]
        }
    }
    
    var body: some View {
        PortfolioInfoView(showEditInfo: $showEditInfo, selectedIndex: $selectedIndex, portfolioStocks: portfolioStocks, upcomingDates: upcomingDividendDates, onDelete: onDelete, onMove: onMove)
            .onAppear(perform: reloadDividendDates)
            .sheet(isPresented: $showEditInfo) {
                EditInfoView(showEditInfo: self.$showEditInfo, portfolioStock: self.portfolioStocks[self.selectedIndex],  selectedIndex: self.selectedIndex, onUpdate: self.onUpdate)
        }
    }
    
    private func reloadDividendDates() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.store.send(updateNextDividendDate(portfolioStocks: self.portfolioStocks))
        }
    }
    
    // List helpers
    private func onDelete(at offsets: IndexSet) {
        store.send(.removeFromPortfolio(offsets: offsets))
    }
    
    private func onMove(from source: IndexSet, to destination: Int) {
        store.send(.moveStockInPortfolio(previous: source, current: destination))
    }
    
    // Edit helpers
    private func onUpdate(index: Int, value: Double) {
        store.send(.updateStartingDividend(index: index, value: value))
    }
}

struct PortfolioInfoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        var appState = AppState()
        appState.portfolioStocks = ["AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL", "AAPL"]
        appState.allPortfolioStocks = ["AAPL": .mock]
        appState.allUpcomingDivDates = ["AAPL": Date()]
        
        return PortfolioInfoContainerView().environmentObject(Store<AppState, AppAction>(initialState: appState, reducer: appReducer))
    }
}
