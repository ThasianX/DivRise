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
    @State private var editMode: EditMode = .inactive
    
    let index: Int
    
    private var ticker: String {
        store.state.portfolioStocks[index]
    }
    
    private var upcomingMonths: [String] {
        let months: [String]
        if let date =  store.state.allUpcomingDivDates[ticker], let stock = store.state.allPortfolioStocks[ticker] {
            if stock.frequency == "Quarterly" {
                months = appendMonths(startingDate: date, freq: 3)
            } else if stock.frequency == "Semi-Annual" {
                months = appendMonths(startingDate: date, freq: 6)
            } else {
                months = appendMonths(startingDate: date, freq: 1)
            }
        } else {
            months = []
        }
        return months
    }
    
    private var editButton: some View {
        Button(action: {
            withAnimation {
                UIApplication.shared.endEditing(true)
                self.resetInput()
                self.editMode.toggle()
            }
        }) {
            Text(self.editMode.title)
        }
    }
    
    var body: some View {
        PositionDetailsView(
            editMode: $editMode,
            showStockDetail: $showStockDetail,
            numOfShares: $numOfShares,
            avgCostPerShare: $avgCostPerShare,
            stock: store.state.allPortfolioStocks[ticker]!,
            holdingInfo: store.state.allHoldingsInfo[ticker],
            currentSharePrice: store.state.currentSharePrices[index],
            onCommit: editHolding,
            upcomingMonths: upcomingMonths
        )
            .navigationBarTitle("Position Details")
            .navigationBarItems(trailing: (store.state.allHoldingsInfo[ticker] == nil) ? nil : editButton)
            .sheet(isPresented: $showStockDetail) {
                PortfolioDetailContainerView(
                    portfolioStock: self.store.state.allPortfolioStocks[self.ticker]!,
                    selectedPeriod: self.store.state.selectedPeriod,
                    attributeNames: self.store.state.attributeNames,
                    show: self.$showStockDetail
                )
                    .environmentObject(self.store)
        }
    }
    
    private func appendMonths(startingDate: Date, freq: Int) -> [String] {
        var months = [String]()
        var date = startingDate
        months.append(startingDate.mediumStyle)
        for _ in 0..<freq {
            date = Calendar.current.date(byAdding: .month, value: freq, to: date)!
            months.append(date.mediumStyle)
        }
        return months
    }
    
    private func editHolding(stock: PortfolioStock) {
        let currentHoldingInfo = store.state.allHoldingsInfo[ticker]
        
        if let shares = Double(numOfShares), let avgCost = Double(avgCostPerShare) {
            let holdingInfo = HoldingInfo(numOfShares: shares, avgCostPerShare: avgCost)
            addHoldingInfo(ticker: stock.ticker, holdingInfo: holdingInfo)
        } else if let avgCost = Double(avgCostPerShare), Double(numOfShares) == nil {
            if let holding = currentHoldingInfo {
                let holdingInfo = HoldingInfo(numOfShares: holding.numOfShares, avgCostPerShare: avgCost)
                addHoldingInfo(ticker: stock.ticker, holdingInfo: holdingInfo)
            }
        } else if let shares = Double(numOfShares), Double(avgCostPerShare) == nil {
            if let holding = currentHoldingInfo {
                let holdingInfo = HoldingInfo(numOfShares: shares, avgCostPerShare: holding.avgCostPerShare)
                addHoldingInfo(ticker: stock.ticker, holdingInfo: holdingInfo)
            }
        }
    }
    
    private func addHoldingInfo(ticker: String, holdingInfo: HoldingInfo) {
        store.send(.addHoldingInfo(ticker: ticker, holdingInfo: holdingInfo))
        resetInput()
    }
    
    private func resetInput() {
        numOfShares = ""
        avgCostPerShare = ""
    }
}
