//
//  DetailStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct DetailStock: Codable, Hashable {
    var record: Record
    var payoutRatio: Double
    var fcfe: Double
    var netDebtToEBITDA: Double
    var peRatio: Double
    var dividendYield: Double
    var grahamNumber: Double
    var dividendPerShare: Double
    var roic: Double
    var debtToEquity: Double
    var operatingProfitMargin: Double
    var assetTurnoverRatio: Double
    var debtToCapitalRatio: Double
    var pegRatio: Double
}

extension DetailStock {
    static let mock = DetailStock(record: Record(month: "Dec", year: "2019"), payoutRatio: 0.0, fcfe: 0.0, netDebtToEBITDA: 0.0, peRatio: 0.0, dividendYield: 0.0, grahamNumber: 0.0, dividendPerShare: 0.0, roic: 0.0, debtToEquity: 0.0, operatingProfitMargin: 0.0, assetTurnoverRatio: 0.0, debtToCapitalRatio: 0.0, pegRatio: 0.0)
}
