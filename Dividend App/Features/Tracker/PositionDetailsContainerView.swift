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
    
    var upcomingMonths: [String] {
        var months = [String]()
        if var date =  store.state.allUpcomingDivDates[getTicker()], let stock = store.state.allPortfolioStocks[getTicker()] {
            if stock.frequency == "Quarterly" {
                months.append(date.mediumStyle)
                for _ in 0...2 {
                    date = Calendar.current.date(byAdding: .month, value: 3, to: date)!
                    months.append(date.mediumStyle)
                }
            } else if stock.frequency == "Semi-Annual" {
                months.append(date.mediumStyle)
                for _ in 0...2 {
                    date = Calendar.current.date(byAdding: .month, value: 6, to: date)!
                    months.append(date.mediumStyle)
                }
            } else {
                months.append(date.mediumStyle)
                for _ in 0...2 {
                    date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
                    months.append(date.mediumStyle)
                }
            }
        }
        return months
    }
    
    var body: some View {
        PositionDetailsView(
            showStockDetail: $showStockDetail,
            numOfShares: $numOfShares,
            avgCostPerShare: $avgCostPerShare,
            stock: store.state.allPortfolioStocks[getTicker()]!,
            holdingInfo: store.state.allHoldingsInfo[getTicker()],
            currentSharePrice: store.state.currentSharePrices[index],
            onCommit: editHolding,
            upcomingMonths: upcomingMonths
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
        let currentHoldingInfo = store.state.allHoldingsInfo[getTicker()]
        
        if let shares = Double(numOfShares), let avgCost = Double(avgCostPerShare) {
            let holdingInfo = HoldingInfo(numOfShares: shares, avgCostPerShare: avgCost)
            addAndReset(ticker: stock.ticker, holdingInfo: holdingInfo)
        } else if let avgCost = Double(avgCostPerShare), Double(numOfShares) == nil {
            if let holding = currentHoldingInfo {
                let holdingInfo = HoldingInfo(numOfShares: holding.numOfShares, avgCostPerShare: avgCost)
                addAndReset(ticker: stock.ticker, holdingInfo: holdingInfo)
            }
        } else if let shares = Double(numOfShares), Double(avgCostPerShare) == nil {
            if let holding = currentHoldingInfo {
                let holdingInfo = HoldingInfo(numOfShares: shares, avgCostPerShare: holding.avgCostPerShare)
                addAndReset(ticker: stock.ticker, holdingInfo: holdingInfo)
            }
        }
    }
    
    private func addAndReset(ticker: String, holdingInfo: HoldingInfo) {
        store.send(.addHoldingInfo(ticker: ticker, holdingInfo: holdingInfo))
        numOfShares = ""
        avgCostPerShare = ""
    }
}
