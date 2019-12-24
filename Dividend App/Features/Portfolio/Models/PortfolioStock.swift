//
//  PortfolioStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct PortfolioStock: Codable, Identifiable, Hashable {
    let id: String
    let ticker: String
    let startingDividend: Double
    let currentDividend: Double
    let growth: Double
}

extension PortfolioStock {
    static let mock = PortfolioStock(id: "com_NX6GzO", ticker: "AAPL", startingDividend: 0.55, currentDividend: 0.77, growth: 0.77 / 0.55)
}
