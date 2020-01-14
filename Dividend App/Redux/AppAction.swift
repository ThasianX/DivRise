//
//  App.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

enum AppAction {
    // MARK: Notifications
    case toggleNotifications(enabled: Bool)
    case setNotificationDay(day: Int)
    case setNotificationTime(time: Date)
    
    // MARK: Portfolio
    case addToPortfolio(stock: PortfolioStock, dividend: UpcomingDividend)
    case removeFromPortfolio(offsets: IndexSet)
    case moveStockInPortfolio(previous: IndexSet, current: Int)
    case updateStartingDividend(index: Int, value: Double)
    case updatePortfolio(stocks: [PortfolioStock])
    case updateUpcomingDivDates(dividends: [UpcomingDividend])
    
    // MARK: Search
    case setSearchResults(results: [SearchStock])
    
    // MARK: Dividend Tracker
    case addHoldingInfo(ticker: String, holdingInfo: HoldingInfo)
    case setCurrentSharePrices(prices: [Double])
    
    // MARK: Dividend Income
    case addMonthlyDividend(record: Record, amount: Double)
    
    // MARK: Stock Detail
    case setDetailStock(detail: DetailStock?)
    case setSelectedPeriod(period: String)
    case setAttributeNames(attributeNames: [String])
    case setStockNews(news: [StockNews])
}


