//
//  CompanyCashFlowStatementResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct CompanyCashFlowStatementResponse: Codable, Hashable {
    let symbol: String
    let financials: [Financial]
    
    // MARK: - Financial
    struct Financial: Codable, Hashable {
        let date, depreciationAmortization, stockBasedCompensation, operatingCashFlow: String
        let capitalExpenditure, acquisitionsAndDisposals, investmentPurchasesAndSales, investingCashFlow: String
        let issuanceRepaymentOfDebt, issuanceBuybacksOfShares, dividendPayments, financingCashFlow: String
        let effectOfForexChangesOnCash, netCashFlowChangeInCash, freeCashFlow, netCashMarketcap: String

        enum CodingKeys: String, CodingKey {
            case date
            case depreciationAmortization = "Depreciation & Amortization"
            case stockBasedCompensation = "Stock-based compensation"
            case operatingCashFlow = "Operating Cash Flow"
            case capitalExpenditure = "Capital Expenditure"
            case acquisitionsAndDisposals = "Acquisitions and disposals"
            case investmentPurchasesAndSales = "Investment purchases and sales"
            case investingCashFlow = "Investing Cash flow"
            case issuanceRepaymentOfDebt = "Issuance (repayment) of debt"
            case issuanceBuybacksOfShares = "Issuance (buybacks) of shares"
            case dividendPayments = "Dividend payments"
            case financingCashFlow = "Financing Cash Flow"
            case effectOfForexChangesOnCash = "Effect of forex changes on cash"
            case netCashFlowChangeInCash = "Net cash flow / Change in cash"
            case freeCashFlow = "Free Cash Flow"
            case netCashMarketcap = "Net Cash/Marketcap"
        }
    }
}

extension CompanyCashFlowStatementResponse {
    static let noResponse = CompanyCashFlowStatementResponse(
        symbol: "", financials: []
    )
}

