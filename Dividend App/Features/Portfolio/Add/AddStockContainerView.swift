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
            onCommit: fetch
            )
            .onAppear(perform: fetch)
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(selectedStock!.ticker),
                    primaryButton: .destructive(Text("Add")),
                    secondaryButton: .cancel())
        }
        .navigationBarTitle(Text("Add Stocks"))
    }
    
    private func fetch() {
        store.send(search(query: query))
    }
    
    private func addStock(stock: SearchStock) {
        store.send(AppAction.addToPortfolio(ticker: stock.ticker))
    }
}
