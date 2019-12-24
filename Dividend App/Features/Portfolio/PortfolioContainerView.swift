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
    @State private var addStocksShown = false
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var body: some View {
        PortfolioView(portfolioStocks: portfolioStocks)
        .navigationBarTitle("portfolio")
        .navigationBarItems(leading: EditButton())
        .navigationBarItems(trailing: Text("Add button"))
            .sheet(isPresented: $addStocksShown) {
                Text("Container view goes here")
        }
    }
}

