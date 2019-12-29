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
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var body: some View {
        PortfolioView(portfolioStocks: portfolioStocks, onDelete: onDelete)
            .navigationBarTitle(Text("portfolio"))
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                NavigationLink(destination: AddStockContainerView().environmentObject(self.store)) {
                    Text("Add")
                }
        )
            .onAppear(perform: reloadDividends)
    }
    
    private func onDelete(at offsets: IndexSet) {
        store.send(.removeFromPortfolio(offsets: offsets))
    }
    
    private func reloadDividends() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.store.send(updatePortfolio(portfolioStocks: self.portfolioStocks))
        }
    }
}

