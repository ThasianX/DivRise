//
//  PositionDetailsContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct PositionDetailsContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var showStockDetail: Bool = false
    @State private var numOfShares: String = ""
    @State private var avgCostPerShare: String = ""
    
    let index: Int
    
    var body: some View {
        PositionDetailsView(
            showStockDetail: $showStockDetail,
            numOfShares: $numOfShares,
            avgCostPerShare: $avgCostPerShare,
            stock: store.state.allPortfolioStocks[getTicker()]!,
            holdingInfo: store.state.allHoldingsInfo[getTicker()],
            currentSharePrice: store.state.currentSharePrices[index],
            onCommit: editHolding
        )
            .navigationBarTitle("Position Details")
            .navigationBarItems(trailing: (store.state.allHoldingsInfo[getTicker()] == nil) ? nil : EditButton())
            .sheet(isPresented: $showStockDetail) {
                PortfolioDetailContainerView(
                    portfolioStock: self.store.state.allPortfolioStocks[self.getTicker()]!,
                    selectedPeriod: self.store.state.selectedPeriod,
                    attributeNames: self.store.state.attributeNames,
                    show: self.$showStockDetail
                )
                .environmentObject(self.store)
        }
    }
    
    private func getTicker() -> String {
        return store.state.portfolioStocks[index]
    }
    
    private func editHolding(stock: PortfolioStock) {
        if let shares = Double(numOfShares), let cost = Double(avgCostPerShare) {
            let holdingInfo = HoldingInfo(numOfShares: shares, avgCostPerShare: cost)
            store.send(.addHoldingInfo(ticker: stock.ticker, holdingInfo: holdingInfo))
            numOfShares = ""
            avgCostPerShare = ""
        }
    }
}

//struct PositionDetailsContainerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PositionDetailsContainerView(portfolioStocks: <#T##PortfolioStock#>, holdingsInfo: <#T##HoldingInfo?#>, currentSharePrices: <#T##Double#>)
//    }
//}
