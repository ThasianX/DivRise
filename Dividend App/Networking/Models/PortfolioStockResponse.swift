//
//  PortfolioStockResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

// MARK: - PortfolioStock
struct PortfolioStockResponse: Codable, Hashable {
    let exDividend: Double
    let currency, announcementDate, recordDate, payDate: String
    let frequency: String
    let forwardYield, forwardRate: Double
    let security: Security

    enum CodingKeys: String, CodingKey {
        case exDividend = "ex_dividend"
        case currency
        case announcementDate = "announcement_date"
        case recordDate = "record_date"
        case payDate = "pay_date"
        case frequency
        case forwardYield = "forward_yield"
        case forwardRate = "forward_rate"
        case security
    }
}

// MARK: - Security
struct Security: Codable, Hashable {
    let id, companyID, stockExchangeID, name: String
    let code, currency, ticker, compositeTicker: String
    let figi, compositeFigi, shareClassFigi: String

    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case stockExchangeID = "stock_exchange_id"
        case name, code, currency, ticker
        case compositeTicker = "composite_ticker"
        case figi
        case compositeFigi = "composite_figi"
        case shareClassFigi = "share_class_figi"
    }
}

extension PortfolioStockResponse {
    static let mock = PortfolioStockResponse(exDividend: 0.77, currency: "USD", announcementDate: "2019-07-30", recordDate: "2019-08-12", payDate: "2019-08-15", frequency: "QUARTERLY", forwardYield: 0.014441, forwardRate: 3.08, security: Security(id: "sec_agjrgj", companyID: "com_NX6GzO", stockExchangeID: "sxg_ozMr9y", name: "Apple Inc", code: "EQS", currency: "USD", ticker: "AAPL", compositeTicker: "AAPL:US", figi: "BBG000B9Y5X2", compositeFigi: "BBG000B9XRY4", shareClassFigi: "BBG001S5N8V8"))
}
