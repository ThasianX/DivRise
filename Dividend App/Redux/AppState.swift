//
//  AppState.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct AppState: Codable, Equatable {
    // MARK: Notifications
    var notificationsSet: Bool = false
    var notificationDay: Int = 1
    var notificationTime: Date = Date().dateAtTime(hour: 7, minute: 0)
    
    // MARK: Main Portfolio
    var allPortfolioStocks: [String: PortfolioStock] = [:]
    var portfolioStocks: [String] = []
    
    // MARK: Portfolio Info
    var allMonthlyRecords: [Record] = []
    var allUpcomingDivDates: [String: Date] = [:]
    var allMonthlyDividends: [Double] = []
    
    // MARK: Search
    var searchResult: [SearchStock] = []
    
    // MARK: Stock Details
    var currentDetailStock: DetailStock?
    var selectedPeriod: String = "annual"
    var attributeNames: [String] = [DetailAttributes.sharePrices, DetailAttributes.peRatios, DetailAttributes.pegRatios, DetailAttributes.payoutRatios, DetailAttributes.dividendYields, DetailAttributes.dividendPerShares, DetailAttributes.fcfes, DetailAttributes.netDebtToEBITDAs, DetailAttributes.grahamNumbers, DetailAttributes.debtToEquitys, DetailAttributes.operatingProfitMargins, DetailAttributes.debtToCapitalRatios]
    var currentStockNews: [StockNews] = []
}
