//
//  DetailAttributes.swift
//  Dividend App
//
//  Created by Kevin Li on 12/29/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct DetailAttributes {
    static let payoutRatios = "payoutRatios"
    static let fcfes = "fcfes"
    static let netDebtToEBITDAs = "netDebtToEBITDAs"
    static let peRatios = "peRatios"
    static let dividendYields = "dividendYields"
    static let grahamNumbers = "grahamNumbers"
    static let dividendPerShares = "dividendPerShares"
    static let debtToEquitys = "debtToEquitys"
    static let operatingProfitMargins = "operatingProfitMargins"
    static let assetTurnoverRatios = "assetTurnoverRatios"
    static let debtToCapitalRatios = "debtToCapitalRatios"
    static let pegRatios = "pegRatios"
    
    static let abbreviated = ["payoutRatios": "Payout", "fcfes": "FCFE", "netDebtToEBITDAs": "ND/EBITDA", "peRatios": "P/E", "dividendYields": "Yield", "grahamNumbers": "Graham", "dividendPerShares": "DPS", "debtToEquitys": "D/E", "operatingProfitMargins": "OPM", "assetTurnoverRatios": "ATR", "debtToCapitalRatios": "D/C", "pegRatios": "PEG"]
    
    static let full = ["payoutRatios": "Payout Ratio", "fcfes": "Free Cash Flow to Equity", "netDebtToEBITDAs": "Net Debt-to-EBITDA", "peRatios": "Price-Earnings Ratio", "dividendYields": "Dividend Yield", "grahamNumbers": "Graham Number", "dividendPerShares": "Dividend per Share", "debtToEquitys": "Debt-To-Equity Ratio", "operatingProfitMargins": "Operating Profit Margin", "assetTurnoverRatios": "Asset Turnover Ratio", "debtToCapitalRatios": "Debt-to-Capital Ratio", "pegRatios": "Price/Earnings-to-Growth Ratio"]

}
