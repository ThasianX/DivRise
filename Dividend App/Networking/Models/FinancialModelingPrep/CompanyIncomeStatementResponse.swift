//
//  CompanyIncomeStatementResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct CompanyIncomeStatementResponse: Codable, Hashable {
    let symbol: String
    let financials: [Financial]
    
    // MARK: Financial
    struct Financial: Codable, Hashable {
        let date, revenue, revenueGrowth, costOfRevenue: String
        let grossProfit, rDExpenses, sgAExpense, operatingExpenses: String
        let operatingIncome, interestExpense, earningsBeforeTax, incomeTaxExpense: String
        let netIncomeNonControllingInt, netIncomeDiscontinuedOps, netIncome, preferredDividends: String
        let netIncomeCOM, eps, epsDiluted, weightedAverageShsOut: String
        let weightedAverageShsOutDil, dividendPerShare, grossMargin, ebitdaMargin: String
        let ebitMargin, profitMargin, freeCashFlowMargin, ebitda: String
        let ebit, consolidatedIncome, earningsBeforeTaxMargin, netProfitMargin: String

        enum CodingKeys: String, CodingKey {
            case date
            case revenue = "Revenue"
            case revenueGrowth = "Revenue Growth"
            case costOfRevenue = "Cost of Revenue"
            case grossProfit = "Gross Profit"
            case rDExpenses = "R&D Expenses"
            case sgAExpense = "SG&A Expense"
            case operatingExpenses = "Operating Expenses"
            case operatingIncome = "Operating Income"
            case interestExpense = "Interest Expense"
            case earningsBeforeTax = "Earnings before Tax"
            case incomeTaxExpense = "Income Tax Expense"
            case netIncomeNonControllingInt = "Net Income - Non-Controlling int"
            case netIncomeDiscontinuedOps = "Net Income - Discontinued ops"
            case netIncome = "Net Income"
            case preferredDividends = "Preferred Dividends"
            case netIncomeCOM = "Net Income Com"
            case eps = "EPS"
            case epsDiluted = "EPS Diluted"
            case weightedAverageShsOut = "Weighted Average Shs Out"
            case weightedAverageShsOutDil = "Weighted Average Shs Out (Dil)"
            case dividendPerShare = "Dividend per Share"
            case grossMargin = "Gross Margin"
            case ebitdaMargin = "EBITDA Margin"
            case ebitMargin = "EBIT Margin"
            case profitMargin = "Profit Margin"
            case freeCashFlowMargin = "Free Cash Flow margin"
            case ebitda = "EBITDA"
            case ebit = "EBIT"
            case consolidatedIncome = "Consolidated Income"
            case earningsBeforeTaxMargin = "Earnings Before Tax Margin"
            case netProfitMargin = "Net Profit Margin"
        }
    }
}

extension CompanyIncomeStatementResponse {
    static let noResponse = CompanyIncomeStatementResponse(
        symbol: "", financials: []
    )
}
