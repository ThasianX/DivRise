//
//  SideEffect.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Combine
import Foundation

// MARK: Search
func search(query: String) -> AnyPublisher<AppAction, Never> {
    Current.request.getSearchedStocks(query: query)
        .map { AppAction.setSearchResults(results:
            $0.sorted(by: { $0.ticker < $1.ticker })) }
        .eraseToAnyPublisher()
}

// MARK: Portfolio
func updatePortfolio(portfolioStocks: [PortfolioStock]) -> AnyPublisher<AppAction, Never> {
    Current.request.updatedPortfolioStocks(stocks: portfolioStocks)
        .map { AppAction.updatePortfolio(stocks: $0) }
        .eraseToAnyPublisher()
}

func addStockToPortfolio(stock: PortfolioStock) -> AnyPublisher<AppAction, Never> {
    Current.request.fetchDividendFrequency(portfolioStock: stock)
        .map {
            PortfolioStock(ticker: stock.ticker, fullName: stock.fullName, image: stock.image, startingDividend: stock.startingDividend, currentDividend: stock.currentDividend, growth: stock.growth, sector: stock.sector, frequency: $0)
    }
    .flatMap { updatedStock in
        Current.request.updatedUpcomingDividendDates(stocks: [updatedStock])
            .map { AppAction.addToPortfolio(stock: updatedStock, dividend: $0.first!) }
            .eraseToAnyPublisher()
    }
    .eraseToAnyPublisher()
}

func updateNextDividendDate(portfolioStocks: [PortfolioStock]) -> AnyPublisher<AppAction, Never> {
    Current.request.updatedUpcomingDividendDates(stocks: portfolioStocks)
        .map { AppAction.updateUpcomingDivDates(dividends: $0) }
        .eraseToAnyPublisher()
}

func updateMonthlyDividends(dividend: Double) -> AnyPublisher<AppAction, Never> {
    let date = Date().getPreviousMonth()!
    let record = Record(month: date.monthMedium, day: nil, year: date.year)
    
    return Just(AppAction.addMonthlyDividend(record: record, amount: dividend))
        .eraseToAnyPublisher()
}

// MARK: Stock Detail
func setCurrentDetailStock(identifier: String, period: String) -> AnyPublisher<AppAction, Never> {
    return Publishers.CombineLatest4(Current.request.getCompanyKeyMetrics(identifier: identifier, period: period), Current.request.getCompanyBalanceSheet(identifier: identifier, period: period), Current.request.getCompanyIncomeStatement(identifier: identifier, period: period), Current.request.getCompanyCashFlowStatement(identifier: identifier, period: period)).combineLatest( Current.request.getStockHistoricalPriceURL(identifier: identifier))
        .receive(on: RunLoop.main)
        .map { publisher1, historicalPrices in
            var records = [Record]()
            var payoutRatios = [Double]()
            var fcfes = [Double]()
            var netDebtToEBITDAs = [Double]()
            var peRatios = [Double]()
            var dividendYields = [Double]()
            var grahamNumbers = [Double]()
            var dividendPerShares = [Double]()
            var debtToEquitys = [Double]()
            var operatingProfitMargins = [Double]()
            var debtToCapitalRatios = [Double]()
            
            let minimum = min(min(publisher1.0.metrics.count, publisher1.1.financials.count), min(publisher1.2.financials.count, publisher1.3.financials.count))
            
            for i in 0..<minimum {
                if let date = Formatter.fullString.date(from: publisher1.0.metrics[i].date) {
                    records.append(Record(month: date.monthMedium, day: nil, year: date.year))
                }
                
                if let val = Double(publisher1.0.metrics[i].payoutRatio) {
                    payoutRatios.append(val*100)
                }
                
                if let val = Double(publisher1.0.metrics[i].netDebtToEBITDA) {
                    netDebtToEBITDAs.append(val)
                }
                
                if let peRatio = Double(publisher1.0.metrics[i].peRatio) {
                    peRatios.append(peRatio)
                }
                
                if let val = Double(publisher1.0.metrics[i].dividendYield) {
                    dividendYields.append(val*100)
                }
                
                if let val = Double(publisher1.0.metrics[i].grahamNumber) {
                    grahamNumbers.append(val)
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
                    operatingProfitMargins.append((ebit / revenue)*100)
                }
                
                if let totalDebt = Double(publisher1.1.financials[i].totalDebt),
                    let totalShareholderEquity = Double(publisher1.1.financials[i].totalShareholdersEquity) {
                    debtToCapitalRatios.append(totalDebt / (totalDebt + totalShareholderEquity))
                }
                
            }
            
            var sharePriceRecords = [Record]()
            var sharePrices = [Double]()
            let range = 1500
            
            if historicalPrices.historical.count > range {
                for i in ((historicalPrices.historical.count - range)..<historicalPrices.historical.count).reversed() {
                    if let date = Formatter.fullString.date(from: historicalPrices.historical[i].date) {
                        sharePriceRecords.append(Record(month: date.monthMedium, day: date.day, year: date.year))
                    }
                    
                    sharePrices.append(historicalPrices.historical[i].close)
                }
            } else {
                for i in (0..<historicalPrices.historical.count).reversed() {
                    if let date = Formatter.fullString.date(from: historicalPrices.historical[i].date) {
                        sharePriceRecords.append(Record(month: date.monthMedium, day: date.day, year: date.year))
                    }
                    
                    sharePrices.append(historicalPrices.historical[i].close)
                }
            }
            
            var details = [String: [Double]]()
            details[DetailAttributes.payoutRatios] = payoutRatios
            details[DetailAttributes.fcfes] = fcfes
            details[DetailAttributes.netDebtToEBITDAs] = netDebtToEBITDAs
            details[DetailAttributes.peRatios] = peRatios
            details[DetailAttributes.dividendYields] = dividendYields
            details[DetailAttributes.grahamNumbers] = grahamNumbers
            details[DetailAttributes.dividendPerShares] = dividendPerShares
            details[DetailAttributes.debtToEquitys] = debtToEquitys
            details[DetailAttributes.operatingProfitMargins] = operatingProfitMargins
            details[DetailAttributes.debtToCapitalRatios] = debtToCapitalRatios
            details[DetailAttributes.sharePrices] = sharePrices
            
            let detailStock = DetailStock(
                records: records,
                sharePriceRecords: sharePriceRecords,
                details: details
            )
            
            return AppAction.setDetailStock(detail: detailStock)
    }
    .eraseToAnyPublisher()
}

func setCurrentNews(query: String) -> AnyPublisher<AppAction, Never> {
    Current.request.getStockNews(query: query)
        .map {
            if $0.status != "ok" {
                Logger.info("\($0.status)")
                return AppAction.setStockNews(news: [])
            } else {
                var stockNews = [StockNews]()
                for article in $0.articles {
                    if let imageUrl = article.urlToImage, let image = URL(string: imageUrl), let url = URL(string: article.url), let publishedDate = article.publishedAt.toLocalTime {
                        let interval = Date().timeIntervalSince(publishedDate)
                        let news = StockNews(title: article.title, source: article.source.name, image: image, url: url, publishedSince: interval.timeIntervalAsString())
                        stockNews.append(news)
                    }
                }
                return AppAction.setStockNews(news: stockNews)
            }
    }
    .eraseToAnyPublisher()
}

// MARK: Dividend Tracker
func setCurrentSharePrices(portfolioStocks: [PortfolioStock]) -> AnyPublisher<AppAction, Never> {
    Current.request.getCurrentSharePrices(stocks: portfolioStocks)
        .map { AppAction.setCurrentSharePrices(prices: $0) }
        .eraseToAnyPublisher()
}
