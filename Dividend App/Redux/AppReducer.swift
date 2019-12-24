//
//  AppReducer.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case let .append(stock):
        state.allPortfolioStocks[stock.ticker] = stock
        state.portfolioStocks.append(stock.ticker)
    }
}
