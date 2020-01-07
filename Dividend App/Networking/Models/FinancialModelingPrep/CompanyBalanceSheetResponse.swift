//
//  CompanyBalanceSheetResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct CompanyBalanceSheetResponse: Codable, Hashable {
    let symbol: String
    let financials: [Financial]
    
    // MARK: - Financial
    struct Financial: Codable, Hashable {
        let date, cashAndCashEquivalents, shortTermInvestments, cashAndShortTermInvestments: String
        let receivables, inventories, totalCurrentAssets, propertyPlantEquipmentNet: String
        let goodwillAndIntangibleAssets, longTermInvestments, taxAssets, totalNonCurrentAssets: String
        let totalAssets, payables, shortTermDebt, totalCurrentLiabilities: String
        let longTermDebt, totalDebt, deferredRevenue, taxLiabilities: String
        let depositLiabilities, totalNonCurrentLiabilities, totalLiabilities, otherComprehensiveIncome: String
        let retainedEarningsDeficit, totalShareholdersEquity, investments, netDebt: String
        let otherAssets, otherLiabilities: String

        enum CodingKeys: String, CodingKey {
            case date
            case cashAndCashEquivalents = "Cash and cash equivalents"
            case shortTermInvestments = "Short-term investments"
            case cashAndShortTermInvestments = "Cash and short-term investments"
            case receivables = "Receivables"
            case inventories = "Inventories"
            case totalCurrentAssets = "Total current assets"
            case propertyPlantEquipmentNet = "Property, Plant & Equipment Net"
            case goodwillAndIntangibleAssets = "Goodwill and Intangible Assets"
            case longTermInvestments = "Long-term investments"
            case taxAssets = "Tax assets"
            case totalNonCurrentAssets = "Total non-current assets"
            case totalAssets = "Total assets"
            case payables = "Payables"
            case shortTermDebt = "Short-term debt"
            case totalCurrentLiabilities = "Total current liabilities"
            case longTermDebt = "Long-term debt"
            case totalDebt = "Total debt"
            case deferredRevenue = "Deferred revenue"
            case taxLiabilities = "Tax Liabilities"
            case depositLiabilities = "Deposit Liabilities"
            case totalNonCurrentLiabilities = "Total non-current liabilities"
            case totalLiabilities = "Total liabilities"
            case otherComprehensiveIncome = "Other comprehensive income"
            case retainedEarningsDeficit = "Retained earnings (deficit)"
            case totalShareholdersEquity = "Total shareholders equity"
            case investments = "Investments"
            case netDebt = "Net Debt"
            case otherAssets = "Other Assets"
            case otherLiabilities = "Other Liabilities"
        }
    }
}

extension CompanyBalanceSheetResponse {
    static let noResponse = CompanyBalanceSheetResponse(
        symbol: "", financials: []
    )
}
