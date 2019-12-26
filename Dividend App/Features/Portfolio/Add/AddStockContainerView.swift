//
//  AddStockContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct AddStockContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var query = ""
    @State private var showingAlert = false
    @State private var alertInput = ""
    @State private var selectedStock: SearchStock? = nil
    
    var body: some View {
        SearchStockView(
            query: $query,
            showingAlert: $showingAlert,
            selectedStock: $selectedStock,
            searchedStocks: store.state.searchResult,
            onCommit: searchStocks
            )
            .addAlert(isShowing: $showingAlert, stock: selectedStock, input: $alertInput, onAdd: addStock)
            .navigationBarTitle(Text("search"))
            .onDisappear(perform: clearSearchResults)
    }
    
    private func searchStocks() {
        store.send(search(query: query))
    }
    
    private func addStock() {
        if let stock = selectedStock {
            let portfolioStock = PortfolioStock(ticker: stock.ticker, startingDividend: Double(alertInput)!, currentDividend: Double(stock.dividend)!, growth: Double(stock.dividend)! / Double(alertInput)!)
            store.send(.addToPortfolio(stock: portfolioStock))
        }
    }
    
    private func clearSearchResults() {
        store.send(.setSearchResults(results: []))
    }
}
