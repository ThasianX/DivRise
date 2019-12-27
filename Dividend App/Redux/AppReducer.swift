//
//  AppReducer.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case let .addToPortfolio(stock):
        state.allPortfolioStocks[stock.ticker] = stock
        state.portfolioStocks.append(stock.ticker)
        
    case let .removeFromPortfolio(offsets):
        state.portfolioStocks.remove(atOffsets: offsets)
        
    case let .updatePortfolio(stocks):
        stocks.forEach { state.allPortfolioStocks[$0.ticker] = $0 }
        
    case let .setSearchResults(results):
        state.searchResult = results
        
    case let .addMonthlyDividend(record, dividend):
        if state.allMonthlyRecords.last == record {
            let lastIndex = state.allMonthlyRecords.count - 1
            state.allMonthlyRecords[lastIndex] = record
            state.allMonthlyDividends[lastIndex] = dividend
        } else {
            state.allMonthlyRecords.append(record)
            state.allMonthlyDividends.append(dividend)
        }
    }
}
