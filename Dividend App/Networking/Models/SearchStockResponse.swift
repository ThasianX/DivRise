//
//  SearchStockResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct SearchStockResponse: Codable {
    let companies: [Company]
}

// MARK: - Company
struct Company: Codable {
    let id, ticker, name: String
    let lei: String?
    let cik: String
}
