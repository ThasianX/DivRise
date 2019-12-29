//
//  CompanyFinancialRatioResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct CompanyFinancialRatioResponse: Codable {
    let symbol: String
    let ratios: [Ratio]
    
    // MARK: - Ratio
    struct Ratio: Codable {
        let date: String
        let investmentValuationRatios: InvestmentValuationRatios
        let profitabilityIndicatorRatios: ProfitabilityIndicatorRatios
        let operatingPerformanceRatios: OperatingPerformanceRatios
        let liquidityMeasurementRatios: LiquidityMeasurementRatios
        let debtRatios: DebtRatios
        let cashFlowIndicatorRatios: CashFlowIndicatorRatios
    }

    // MARK: - CashFlowIndicatorRatios
    struct CashFlowIndicatorRatios: Codable {
        let operatingCashFlowPerShare, freeCashFlowPerShare, cashPerShare, payoutRatio: String
        let receivablesTurnover, operatingCashFlowSalesRatio, freeCashFlowOperatingCashFlowRatio, cashFlowCoverageRatios: String
        let shortTermCoverageRatios, capitalExpenditureCoverageRatios, dividendpaidAndCapexCoverageRatios, dividendPayoutRatio: String
    }

    // MARK: - DebtRatios
    struct DebtRatios: Codable {
        let debtRatio, debtEquityRatio, longtermDebtToCapitalization, totalDebtToCapitalization: String
        let interestCoverage, cashFlowToDebtRatio, companyEquityMultiplier: String
    }

    // MARK: - InvestmentValuationRatios
    struct InvestmentValuationRatios: Codable {
        let priceBookValueRatio, priceToBookRatio, priceToSalesRatio, priceEarningsRatio: String
        let receivablesTurnover, priceToFreeCashFlowsRatio, priceToOperatingCashFlowsRatio, priceCashFlowRatio: String
        let priceEarningsToGrowthRatio, priceSalesRatio, dividendYield, enterpriseValueMultiple: String
        let priceFairValue: String
    }

    // MARK: - LiquidityMeasurementRatios
    struct LiquidityMeasurementRatios: Codable {
        let currentRatio, quickRatio, cashRatio, daysOfSalesOutstanding: String
        let daysOfInventoryOutstanding, operatingCycle, daysOfPayablesOutstanding, cashConversionCycle: String
    }

    // MARK: - OperatingPerformanceRatios
    struct OperatingPerformanceRatios: Codable {
        let receivablesTurnover, payablesTurnover, inventoryTurnover, fixedAssetTurnover: String
        let assetTurnover: String
    }

    // MARK: - ProfitabilityIndicatorRatios
    struct ProfitabilityIndicatorRatios: Codable {
        let niperEBT, ebtperEBIT, ebitperRevenue, grossProfitMargin: String
        let operatingProfitMargin, pretaxProfitMargin, netProfitMargin, effectiveTaxRate: String
        let returnOnAssets, returnOnEquity, returnOnCapitalEmployed, nIperEBT: String
        let eBTperEBIT, eBITperRevenue: String
    }
}




extension CompanyFinancialRatioResponse {
    static let noResponse = CompanyFinancialRatioResponse(
        symbol: "", ratios: []
    )
}
