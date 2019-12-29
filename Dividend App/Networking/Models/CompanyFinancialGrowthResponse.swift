//
//  CompanyFinancialGrowthResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct CompanyFinancialGrowthResponse: Codable, Hashable {
    let symbol: String
    let growth: [Growth]
    
    // MARK: - Growth
    struct Growth: Codable, Hashable {
        let date, grossProfitGrowth, ebitGrowth, operatingIncomeGrowth: String
        let netIncomeGrowth, epsGrowth, epsDilutedGrowth, weightedAverageSharesGrowth: String
        let weightedAverageSharesDilutedGrowth, dividendsPerShareGrowth, operatingCashFlowGrowth, freeCashFlowGrowth: String
        let the10YRevenueGrowthPerShare, the5YRevenueGrowthPerShare, the3YRevenueGrowthPerShare, the10YOperatingCFGrowthPerShare: String
        let the5YOperatingCFGrowthPerShare, the3YOperatingCFGrowthPerShare, the10YNetIncomeGrowthPerShare, the5YNetIncomeGrowthPerShare: String
        let the3YNetIncomeGrowthPerShare, the10YShareholdersEquityGrowthPerShare, the5YShareholdersEquityGrowthPerShare, the3YShareholdersEquityGrowthPerShare: String
        let the10YDividendPerShareGrowthPerShare, the5YDividendPerShareGrowthPerShare, the3YDividendPerShareGrowthPerShare, receivablesGrowth: String
        let inventoryGrowth, assetGrowth, bookValuePerShareGrowth, debtGrowth: String
        let rDExpenseGrowth, sgAExpensesGrowth: String

        enum CodingKeys: String, CodingKey {
            case date
            case grossProfitGrowth = "Gross Profit Growth"
            case ebitGrowth = "EBIT Growth"
            case operatingIncomeGrowth = "Operating Income Growth"
            case netIncomeGrowth = "Net Income Growth"
            case epsGrowth = "EPS Growth"
            case epsDilutedGrowth = "EPS Diluted Growth"
            case weightedAverageSharesGrowth = "Weighted Average Shares Growth"
            case weightedAverageSharesDilutedGrowth = "Weighted Average Shares Diluted Growth"
            case dividendsPerShareGrowth = "Dividends per Share Growth"
            case operatingCashFlowGrowth = "Operating Cash Flow growth"
            case freeCashFlowGrowth = "Free Cash Flow growth"
            case the10YRevenueGrowthPerShare = "10Y Revenue Growth (per Share)"
            case the5YRevenueGrowthPerShare = "5Y Revenue Growth (per Share)"
            case the3YRevenueGrowthPerShare = "3Y Revenue Growth (per Share)"
            case the10YOperatingCFGrowthPerShare = "10Y Operating CF Growth (per Share)"
            case the5YOperatingCFGrowthPerShare = "5Y Operating CF Growth (per Share)"
            case the3YOperatingCFGrowthPerShare = "3Y Operating CF Growth (per Share)"
            case the10YNetIncomeGrowthPerShare = "10Y Net Income Growth (per Share)"
            case the5YNetIncomeGrowthPerShare = "5Y Net Income Growth (per Share)"
            case the3YNetIncomeGrowthPerShare = "3Y Net Income Growth (per Share)"
            case the10YShareholdersEquityGrowthPerShare = "10Y Shareholders Equity Growth (per Share)"
            case the5YShareholdersEquityGrowthPerShare = "5Y Shareholders Equity Growth (per Share)"
            case the3YShareholdersEquityGrowthPerShare = "3Y Shareholders Equity Growth (per Share)"
            case the10YDividendPerShareGrowthPerShare = "10Y Dividend per Share Growth (per Share)"
            case the5YDividendPerShareGrowthPerShare = "5Y Dividend per Share Growth (per Share)"
            case the3YDividendPerShareGrowthPerShare = "3Y Dividend per Share Growth (per Share)"
            case receivablesGrowth = "Receivables growth"
            case inventoryGrowth = "Inventory Growth"
            case assetGrowth = "Asset Growth"
            case bookValuePerShareGrowth = "Book Value per Share Growth"
            case debtGrowth = "Debt Growth"
            case rDExpenseGrowth = "R&D Expense Growth"
            case sgAExpensesGrowth = "SG&A Expenses Growth"
        }
    }
}

extension CompanyFinancialGrowthResponse {
    static let noResponse = CompanyFinancialGrowthResponse(
        symbol: "", growth: []
    )
}
