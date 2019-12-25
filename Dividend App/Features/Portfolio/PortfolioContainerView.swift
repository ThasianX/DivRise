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
    @State private var showingAddStocks = false
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var addButton: some View {
        Button(action: { self.showingAddStocks.toggle() }) {
            Text("add")
                .accessibility(label: Text("add stocks"))
        }
    }
    
    var body: some View {
        PortfolioView(portfolioStocks: portfolioStocks)
        .navigationBarTitle(Text("portfolio"))
        .navigationBarItems(
            leading: EditButton(),
            trailing: addButton)
            .sheet(isPresented: $showingAddStocks) {
                AddStockContainerView().environmentObject(self.store)
        }
    }
}

