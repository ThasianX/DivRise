//
//  CompanyKeyMetricsResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct CompanyKeyMetrics: Codable, Hashable {
    let symbol: String
    let metrics: [Metric]

    // MARK: - Metric
    struct Metric: Codable, Hashable {
        let date, marketCap, peRatio, pbRatio: String
        let debtToEquity, netDebtToEBITDA, dividendYield, payoutRatio: String
        let grahamNumber: String

        enum CodingKeys: String, CodingKey {
            case date
            case marketCap = "Market Cap"
            case peRatio = "PE ratio"
            case pbRatio = "PB ratio"
            case debtToEquity = "Debt to Equity"
            case netDebtToEBITDA = "Net Debt to EBITDA"
            case dividendYield = "Dividend Yield"
            case payoutRatio = "Payout Ratio"
            case grahamNumber = "Graham Number"
        }
    }
}


extension CompanyKeyMetrics {
    static let noResponse = CompanyKeyMetrics(
        symbol: "", metrics: []
    )
}
