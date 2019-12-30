//
//  SideEffect.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Combine
import Foundation

func search(query: String) -> AnyPublisher<AppAction, Never> {
    Current.request.getSearchedStocks(query: query)
        .map {
            return .setSearchResults(results: $0)
            
    }
    .eraseToAnyPublisher()
}

func updatePortfolio(portfolioStocks: [PortfolioStock]) -> AnyPublisher<AppAction, Never> {
    Current.request.updatedPortfolioStocks(stocks: portfolioStocks)
        .map {
            return .updatePortfolio(stocks: $0)
    }
    .eraseToAnyPublisher()
}

func updateMonthlyDividends(dividend: Double) -> AnyPublisher<AppAction, Never> {
    let date = Date()
    let record = Record(month: date.monthMedium, year: date.year)
    
    return Just(AppAction.addMonthlyDividend(record: record, amount: dividend))
        .eraseToAnyPublisher()
}

func setCurrentDetailStock(identifier: String, period: String) -> AnyPublisher<AppAction, Never> {
    return Publishers.CombineLatest4(Current.request.getCompanyKeyMetrics(identifier: identifier, period: period), Current.request.getCompanyBalanceSheet(identifier: identifier, period: period), Current.request.getCompanyIncomeStatement(identifier: identifier, period: period), Current.request.getCompanyCashFlowStatement(identifier: identifier, period: period)).combineLatest(Current.request.getCompanyFinancialRatio(identifier: identifier), Current.request.getCompanyFinancialStatementGrowth(identifier: identifier, period: period))
        .receive(on: RunLoop.main)
        .map { publisher1, financialRatio, financialGrowth in
            var records = [Record]()
            var payoutRatios = [Double]()
            var fcfes = [Double]()
            var netDebtToEBITDAs = [Double]()
            var peRatios = [Double]()
            var dividendYields = [Double]()
            var grahamNumbers = [Double]()
            var dividendPerShares = [Double]()
            var roics = [Double]()
            var debtToEquitys = [Double]()
            var operatingProfitMargins = [Double]()
            var assetTurnoverRatios = [Double]()
            var debtToCapitalRatios = [Double]()
            var pegRatios = [Double]()
            
            for i in 0..<publisher1.0.metrics.count {
                if let date = Formatter.fullString.date(from: publisher1.0.metrics[i].date) {
                    records.append(Record(month: date.monthMedium, year: date.year))
                }
                
                if let val = Double(publisher1.0.metrics[i].payoutRatio) {
                    payoutRatios.append(val)
                }
                
                if let val = Double(publisher1.0.metrics[i].netDebtToEBITDA) {
                    netDebtToEBITDAs.append(val)
                }
                
                if let val = Double(publisher1.0.metrics[i].peRatio) {
                    peRatios.append(val)
                }
                
                if let val = Double(publisher1.0.metrics[i].dividendYield) {
                    dividendYields.append(val)
                }
                
                if let val = Double(publisher1.0.metrics[i].grahamNumber) {
                    grahamNumbers.append(val)
                }
                
                if let val = Double(publisher1.0.metrics[i].roic) {
                    roics.append(val)
                }
                
                if let val = Double(publisher1.0.metrics[i].debtToEquity) {
                    debtToEquitys.append(val)
                }
                
                if let ocf = Double(publisher1.3.financials[i].operatingCashFlow),
                    let capitalExp = Double(publisher1.3.financials[i].capitalExpenditure),
                    let repayDebt = Double(publisher1.3.financials[i].issuanceRepaymentOfDebt)
                {
                    fcfes.append(ocf-capitalExp-repayDebt)
                }
                
                if let val = Double(publisher1.2.financials[i].dividendPerShare) {
                    dividendPerShares.append(val)
                }
                
                if let ebit = Double(publisher1.2.financials[i].ebit),
                    let revenue = Double(publisher1.2.financials[i].revenue) {
                    operatingProfitMargins.append(ebit / revenue)
                }
                
                if let val = Double(financialRatio.ratios[i].operatingPerformanceRatios.assetTurnover) {
                    assetTurnoverRatios.append(val)
                }
                
                if let totalDebt = Double(publisher1.1.financials[i].totalDebt),
                    let totalShareholderEquity = Double(publisher1.1.financials[i].totalShareholdersEquity) {
                    debtToCapitalRatios.append(totalDebt / (totalDebt + totalShareholderEquity))
                }
                
                if let peRatio = Double(publisher1.0.metrics[i].peRatio),
                    let epsGrowth = Double(financialGrowth.growth[i].epsGrowth) {
                    pegRatios.append(peRatio / epsGrowth)
                }
                
            }
            let detailStock = DetailStock(
                records: records,
                payoutRatios: payoutRatios,
                fcfes: fcfes,
                netDebtToEBITDAs: netDebtToEBITDAs,
                peRatios: peRatios,
                dividendYields: dividendYields,
                grahamNumbers: grahamNumbers,
                dividendPerShares: dividendPerShares,
                roics: roics,
                debtToEquitys: debtToEquitys,
                operatingProfitMargins: operatingProfitMargins,
                assetTurnoverRatios: (period == "annual") ? assetTurnoverRatios : [],
                debtToCapitalRatios: debtToCapitalRatios,
                pegRatios: pegRatios
            )
            return AppAction.setDetailStock(detail: detailStock)
    }
    .eraseToAnyPublisher()
}
