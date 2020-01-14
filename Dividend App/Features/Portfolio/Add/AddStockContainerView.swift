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
    
    @Binding var show: Bool
    
    @State private var query = ""
    
    @State private var showingAlert = false
    @State private var alertInput = ""
    @State private var selectedStock: SearchStock? = nil
    @State private var showCancelButton: Bool = false
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            SearchStockView(
                query: $query,
                showCancelButton: $showCancelButton,
                showingAlert: $showingAlert,
                selectedStock: $selectedStock,
                searchedStocks: store.state.searchResult,
                onCommit: searchStocks
            )
                .onDisappear(perform: clearSearch)
                .addTextFieldAlert(isShowing: $showingAlert, stock: selectedStock, input: $alertInput, onAdd: addStock)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorMessage), dismissButton: .default(Text("Got it")))
            }
            .animation(.easeInOut)
            .navigationBarTitle(Text("Add Stocks"))
            .navigationBarItems(trailing:
                ExitButton(show: $show)
            )
        }
    }
    
    // Search helpers
    private func clearSearch() {
        self.store.send(.setSearchResults(results: []))
    }
    
    private func searchStocks() {
        store.send(search(query: query.trimmingCharacters(in: .whitespacesAndNewlines)))
    }
    
    private func addStock() {
        if let stock = selectedStock, let currentDividend = Double(stock.dividend), let startingDividend = Double(alertInput) {
            
            if stock.dividend == "0" {
                errorMessage = "Must choose stock with dividends"
                showingError = true
            } else if startingDividend == 0 {
                errorMessage = "Starting dividend cannot be 0"
                showingError = true
            } else if store.state.allPortfolioStocks.keys.contains(stock.ticker) {
                errorMessage = "Your portfolio already contains \(stock.ticker). To edit, visit info"
                showingError = true
            } else {
                let growth = ((currentDividend / startingDividend) - 1.0) * 100
                let portfolioStock = PortfolioStock(ticker: stock.ticker, fullName: stock.fullName, image: stock.image, startingDividend: startingDividend, currentDividend: currentDividend, growth: growth, sector: stock.sector, frequency: "")
                store.send(addStockToPortfolio(stock: portfolioStock))
            }
        }
    }
}

struct AddStockContainerView_Previews: PreviewProvider {
    static var previews: some View {
        var appState = AppState()
        appState.searchResult = [.mock, .mock, .mock, .mock]
        
        return AddStockContainerView(show: .constant(true))
            .environmentObject(Store<AppState, AppAction>(initialState: appState, reducer: appReducer))
    }
}
