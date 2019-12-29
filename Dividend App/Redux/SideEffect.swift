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
            
    }
}
