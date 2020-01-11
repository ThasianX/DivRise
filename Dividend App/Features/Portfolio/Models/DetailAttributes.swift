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
    static let debtToCapitalRatios = "debtToCapitalRatios"
    static let sharePrices = "sharePrices"
    
    static let defaultOrder = [DetailAttributes.sharePrices, DetailAttributes.peRatios, DetailAttributes.payoutRatios, DetailAttributes.dividendYields, DetailAttributes.dividendPerShares, DetailAttributes.fcfes, DetailAttributes.netDebtToEBITDAs, DetailAttributes.grahamNumbers, DetailAttributes.debtToEquitys, DetailAttributes.operatingProfitMargins, DetailAttributes.debtToCapitalRatios]
    
    static let abbreviated = [
        payoutRatios: "Payout",
        fcfes: "FCFE",
        netDebtToEBITDAs: "ND/EBITDA",
        peRatios: "P/E",
        dividendYields: "Yield",
        grahamNumbers: "Graham",
        dividendPerShares: "DPS",
        debtToEquitys: "D/E",
        operatingProfitMargins: "OPM",
        debtToCapitalRatios: "D/C",
        sharePrices: "Price"
    ]
    
    static let full = [
        payoutRatios: "Payout Ratio",
        fcfes: "Free Cash Flow to Equity",
        netDebtToEBITDAs: "Net Debt-to-EBITDA",
        peRatios: "Price-Earnings Ratio",
        dividendYields: "Dividend Yield",
        grahamNumbers: "Graham Number",
        dividendPerShares: "Dividend per Share",
        debtToEquitys: "Debt-To-Equity Ratio",
        operatingProfitMargins: "Operating Profit Margin",
        debtToCapitalRatios: "Debt-to-Capital Ratio",
        sharePrices: "Share Price"
    ]
    
    static let descriptions = [
        payoutRatios: "Generally, the less of its earnings a company pays out for dividends, the more potential it has to raise dividends in the future. Doesn't apply for specific industries like Real Estate.",
        fcfes: "Measures the amount of cash that could be paid out to shareholders after all expenses and debts have been paid. You want to compare this to the dividend payments to see if they are fully covered by this amount.",
        netDebtToEBITDAs: "Measures a company's leverage and its ability to meet debt. The lower, when compared to its industry average, the better as it would take less for the company to pay its debt back. A ratio over 3 is usually not worth investing.",
        peRatios: "The lower the ratio, when compared to companies in the same sector, the more attractive the company's stock since you're paying less for $1 of its earnings. A ratio below 20 is worth investing.",
        dividendYields: "Stock's annual dividend payments, as a percentage of the share's current price. The greater the yield, the more value you are getting for buying a share.",
        grahamNumbers: "Stock's fundamental value, based on company's EPS and BVPS. If the current share price of the stock is below this number, then the stock is undervalued and worth investing.",
        dividendPerShares: "Take dividend yield and multiply it by the current share price to get DPS. The higher, the more direct income you get.",
        debtToEquitys: "Measures the degree to which a company is financing its operation through total liabilities versus shareholder equity. The lower the ratio, the lower the leverage, and thus the lower the risk. A ratio over 2 is usually not worth investing.",
        operatingProfitMargins: "Represents the company's earnings before interest and taxes. Higher and more stable margins are preferred as they help our earnings compound faster. It also could be a sign that the company has an economic moat.",
        debtToCapitalRatios: "Measure of how much interest bearing debt a company is using to finance its business. Useful because if a company fails, it pays debt first, then shareholders, and we want to know the risk. A ratio over 50% is usually not worth investing, unless it's utilities.",
        sharePrices: "Price of a single share of stock in the company. Generally, a good time to buy a stock is when its share prices are below historical averages and if you are confident that the stock will do well in the future."
        ]

}
