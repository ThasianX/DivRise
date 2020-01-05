//
//  App.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

enum AppAction {
    case toggleNotifications(enabled: Bool)
    case addToPortfolio(stock: PortfolioStock)
    case removeFromPortfolio(offsets: IndexSet)
    case moveStockInPortfolio(previous: IndexSet, current: Int)
    case updateStartingDividend(index: Int, value: Double)
    case updatePortfolio(stocks: [PortfolioStock])
    case addUpcomingDivDate(dividend: UpcomingDividend)
    case updateUpcomingDivDates(dividends: [UpcomingDividend])
    case setSearchResults(results: [SearchStock])
    case addMonthlyDividend(record: Record, amount: Double)
    case setDetailStock(detail: DetailStock?)
    case setStockNews(news: [StockNews])
    case setSelectedPeriod(period: String)
    case setAttributeNames(attributeNames: [String])
}


