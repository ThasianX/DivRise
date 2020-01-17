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
    
    // MARK: Portfolio Sort
    var selectedSort: String = PortfolioSortState.symbol
    var sortDirection: String = SortDirection.down
    
    // MARK: Portfolio Info
    var allUpcomingDivDates: [String: Date] = [:]
    
    // MARK: Dividend Tracker
    var allHoldingsInfo: [String: HoldingInfo] = [:]
    var currentSharePrices: [Double] = []
    
    // MARK: Dividend Income
    var allMonthlyRecords: [Record] = []
    var allMonthlyDividends: [Double] = []
    
    // MARK: Sector Info
    var sectorCompanies: [String: [PortfolioStock]] = SectorAttributes.defaultSectors
    
    // MARK: Search
    var searchResult: [SearchStock] = []
    
    // MARK: Stock Details
    var currentDetailStock: DetailStock?
    var selectedPeriod: String = "annual"
    var attributeNames: [String] = DetailAttributes.defaultOrder
    var currentStockNews: [StockNews] = []
}
