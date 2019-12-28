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
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        SearchStockView(
            query: $query,
            showingAlert: $showingAlert,
            selectedStock: $selectedStock,
            searchedStocks: store.state.searchResult,
            onCommit: searchStocks
            )
            .addTextFieldAlert(isShowing: $showingAlert, stock: selectedStock, input: $alertInput, onAdd: addStock)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorMessage), dismissButton: .default(Text("ok")))
        }
            .navigationBarTitle(Text("search"))
            .onDisappear(perform: clearSearchResults)
    }
    
    private func searchStocks() {
        store.send(search(query: query.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    
    private func addStock() {
        if let stock = selectedStock, let currentDividend = Double(stock.dividend), let startingDividend = Double(alertInput) {
            if startingDividend == 0 {
                errorMessage = "Starting dividend cannot be 0"
                showingError = true
            } else if store.state.allPortfolioStocks.keys.contains(stock.ticker) {
                errorMessage = "Your portfolio already contains \(stock.ticker). To edit, visit settings"
                showingError = true
            } else {
                let growth = ((currentDividend / startingDividend) - 1.0) * 100
                let portfolioStock = PortfolioStock(ticker: stock.ticker, startingDividend: startingDividend, currentDividend: currentDividend, growth: growth)
                store.send(.addToPortfolio(stock: portfolioStock))
            }
        }
    }
    
    private func clearSearchResults() {
        store.send(.setSearchResults(results: []))
    }
}
