//
//  AppState.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct AppState: Codable, Equatable {
    var allPortfolioStocks: [String: PortfolioStock] = [:]
    var portfolioStocks: [String] = []
    var searchResult: [SearchStock] = []
    var allMonthlyRecords: [Record] = []
    var allMonthlyDividends: [Double] = []
}
