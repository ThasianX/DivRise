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
    @State private var selectedIndex = 0
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var body: some View {
        PortfolioView(showingDetail: $showingDetail, selectedIndex: $selectedIndex, portfolioStocks: portfolioStocks, onDelete: onDelete)
            .navigationBarTitle(Text("Portfolio"))
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                NavigationLink(destination: AddStockContainerView().environmentObject(self.store)) {
                    Text("Add")
                }
        )
        .sheet(isPresented: self.$showingDetail) {
            PortfolioDetailContainerView(portfolioStock: self.portfolioStocks[self.selectedIndex])
                .environmentObject(self.store)
        }
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

