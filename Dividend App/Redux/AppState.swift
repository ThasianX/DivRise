//
//  AppState.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct AppState: Codable, Equatable {
    var notificationsSet: Bool = false
    var allPortfolioStocks: [String: PortfolioStock] = [:]
    var portfolioStocks: [String] = []
    var searchResult: [SearchStock] = []
    var allMonthlyRecords: [Record] = []
    var allMonthlyDividends: [Double] = []
    var currentDetailStock: DetailStock?
    var selectedPeriod: String = "annual"
    var attributeNames: [String] = [DetailAttributes.sharePrices, DetailAttributes.peRatios, DetailAttributes.pegRatios, DetailAttributes.payoutRatios, DetailAttributes.dividendYields, DetailAttributes.dividendPerShares, DetailAttributes.fcfes, DetailAttributes.netDebtToEBITDAs, DetailAttributes.grahamNumbers, DetailAttributes.debtToEquitys, DetailAttributes.operatingProfitMargins, DetailAttributes.debtToCapitalRatios]
}


