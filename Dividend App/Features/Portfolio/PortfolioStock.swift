//
//  PortfolioStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct PortfolioStock: Codable, Equatable {
    let ticker: String
    let startingDividend: Double
    let currentDividend: Double
    let growth: Double
}
