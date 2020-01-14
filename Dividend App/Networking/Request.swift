//
//  Portfolio.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation
import Combine

// MARK: AlphaVantage
internal let searchCompanyURL = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords={query}&apikey={apikey}"

// MARK: FinancialModelingPrep
internal let companyProfileURL = "https://financialmodelingprep.com/api/v3/company/profile/{company}"
internal let companyKeyMetricsURL = "https://financialmodelingprep.com/api/v3/company-key-metrics/{company}?period={period}"
internal let companyCashFlowURL = "https://financialmodelingprep.com/api/v3/financials/cash-flow-statement/{company}?period={period}"
internal let companyIncomeURL = "https://financialmodelingprep.com/api/v3/financials/income-statement/{company}?period={period}"
internal let companyBalanceURL = "https://financialmodelingprep.com/api/v3/financials/balance-sheet-statement/{company}?period={period}"
internal let companyFinancialGrowthURL = "https://financialmodelingprep.com/api/v3/financial-statement-growth/{company}?period={period}"
internal let stockHistoricalPriceURL = "https://financialmodelingprep.com/api/v3/historical-price-full/{company}?serietype=line"
internal let currentStockPriceURL = "https://financialmodelingprep.com/api/v3/stock/real-time-price/{company}"

// MARK: NewsAPI
internal let everythingURL = "https://newsapi.org/v2/everything"

// MARK: IEX Cloud
internal let basicDividendURL = "https://cloud.iexapis.com/v1/stock/{company}/dividends/3m?token={apikey}"

struct Request {
    let configuration = Configuration()
    
    // MARK: Main Portfolio
    func updatedPortfolioStocks(stocks: [PortfolioStock]) -> AnyPublisher<[PortfolioStock], Never> {
        let publisherOfPublishers = Publishers.Sequence<[AnyPublisher<PortfolioStock, Never>], Never>(sequence: stocks.map(fetchPortfolioStock))
        return publisherOfPublishers.flatMap { $0 }.collect().eraseToAnyPublisher()
    }
    
    func fetchPortfolioStock(portfolioStock: PortfolioStock) -> AnyPublisher<PortfolioStock, Never> {
        return companyProfile(identifier: portfolioStock.ticker)
            .map {
                PortfolioStock(ticker: $0.symbol, fullName: portfolioStock.fullName, image: portfolioStock.image, startingDividend: portfolioStock.startingDividend, currentDividend: Double($0.profile.lastDiv)!, growth: ((Double($0.profile.lastDiv)! / portfolioStock.startingDividend) - 1.0) * 100, sector: $0.profile.sector, frequency: portfolioStock.frequency)
        }
        .eraseToAnyPublisher()
    }
    
    func fetchDividendFrequency(portfolioStock: PortfolioStock) -> AnyPublisher<String, Never> {
           let urlString = basicDividendURL
               .replacingOccurrences(of: "{company}", with: portfolioStock.ticker.lowercased())
               .replacingOccurrences(of: "{apikey}", with: configuration.iexApiKey)
           let url = URL(string: urlString)!
           
           return URLSession.shared
               .dataTaskPublisher(for: url)
               .map { $0.data }
               .decode(type: BasicDividendResponse.self, decoder: Current.decoder)
                .map { $0.frequency.capitalized }
               .replaceError(with: "Quarterly")
               .eraseToAnyPublisher()
       }
    
    // MARK: Portfolio Info
    func updatedUpcomingDividendDates(stocks: [PortfolioStock]) -> AnyPublisher<[UpcomingDividend], Never> {
        let publisherOfPublishers = Publishers.Sequence<[AnyPublisher<UpcomingDividend, Never>], Never>(sequence: stocks.map(fetchUpcomingDividendDate))
        return publisherOfPublishers.flatMap { $0 }.collect().eraseToAnyPublisher()
    }
    
    func fetchUpcomingDividendDate(portfolioStock: PortfolioStock) -> AnyPublisher<UpcomingDividend, Never> {
        return getCompanyCashFlowStatement(identifier: portfolioStock.ticker, period: "quarter")
            .map {
                var date = DateFormatter.fullString.date(from: $0.financials.first!.date)!
                if portfolioStock.frequency == "Quarterly" {
                    date = Calendar.current.date(byAdding: .month, value: 3, to: date)!
                    if Date() > date {
                        date = Calendar.current.date(byAdding: .month, value: 3, to: date)!
                    }
                } else if portfolioStock.frequency == "Semi-Annual" {
                    date = Calendar.current.date(byAdding: .month, value: 6, to: date)!
                    if Date() > date {
                        date = Calendar.current.date(byAdding: .month, value: 6, to: date)!
                    }
                } else {
                    date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
                    if Date() > date {
                        date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
                    }
                }
                return UpcomingDividend(ticker: portfolioStock.ticker, date: date)
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: Search
    func getSearchedStocks(query: String) -> AnyPublisher<[SearchStock], Never> {
        return searchStocks(query: query)
            .map { $0.bestMatches }
            .flatMap { companies -> Publishers.MergeMany<AnyPublisher<SearchStock, Never>> in
                let stocks = companies.map { company -> AnyPublisher<SearchStock, Never> in
                    let ticker = company.symbol
                    let fullName = company.name
                    return self.companyProfile(identifier: ticker)
                        .flatMap { response -> AnyPublisher<SearchStock, Never> in
                            let mktCap = (response.profile.mktCap == "") ? "$--" : "$\(Double(response.profile.mktCap)!.shortStringRepresentation)"
                            let dividend = response.profile.lastDiv
                            return Just(SearchStock(ticker: ticker, fullName: fullName, image: response.profile.image, marketCap: mktCap, dividend: dividend, sector: response.profile.sector))
                                .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
                }
                return Publishers.MergeMany(stocks)
        }
        .collect()
        .eraseToAnyPublisher()
    }
    
    private func searchStocks(query: String) -> AnyPublisher<SearchStockResponse, Never> {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = searchCompanyURL
            .replacingOccurrences(of: "{query}", with: encodedQuery)
            .replacingOccurrences(of: "{apikey}", with: configuration.alphaVantageApiKey)
        
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: SearchStockResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    // MARK: Portfolio & Search Shared
    private func companyProfile(identifier: String) -> AnyPublisher<CompanyProfileResponse, Never> {
        let urlString = companyProfileURL.replacingOccurrences(of: "{company}", with: identifier)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: CompanyProfileResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    // MARK: Details
    func getCompanyKeyMetrics(identifier: String, period: String) -> AnyPublisher<CompanyKeyMetrics, Never> {
        let urlString = companyKeyMetricsURL
            .replacingOccurrences(of: "{company}", with: identifier)
            .replacingOccurrences(of: "{period}", with: period)
        let url = URL(string: urlString)!
        
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CompanyKeyMetrics.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    func getCompanyCashFlowStatement(identifier: String, period: String) -> AnyPublisher<CompanyCashFlowStatementResponse, Never> {
        let urlString = companyCashFlowURL
            .replacingOccurrences(of: "{company}", with: identifier)
            .replacingOccurrences(of: "{period}", with: period)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CompanyCashFlowStatementResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    func getCompanyIncomeStatement(identifier: String, period: String) -> AnyPublisher<CompanyIncomeStatementResponse, Never> {
        let urlString = companyIncomeURL
            .replacingOccurrences(of: "{company}", with: identifier)
            .replacingOccurrences(of: "{period}", with: period)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CompanyIncomeStatementResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    func getCompanyBalanceSheet(identifier: String, period: String) -> AnyPublisher<CompanyBalanceSheetResponse, Never> {
        let urlString = companyBalanceURL
            .replacingOccurrences(of: "{company}", with: identifier)
            .replacingOccurrences(of: "{period}", with: period)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CompanyBalanceSheetResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    func getCompanyFinancialStatementGrowth(identifier: String, period: String) -> AnyPublisher<CompanyFinancialGrowthResponse, Never> {
        let urlString = companyFinancialGrowthURL
            .replacingOccurrences(of: "{company}", with: identifier)
            .replacingOccurrences(of: "{period}", with: period)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CompanyFinancialGrowthResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    func getStockHistoricalPriceURL(identifier: String) -> AnyPublisher<StockHistoricalPriceResponse, Never> {
        let urlString = stockHistoricalPriceURL
            .replacingOccurrences(of: "{company}", with: identifier)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: StockHistoricalPriceResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    // MARK: News
    func getStockNews(query: String) -> AnyPublisher<NewsEverythingResponse, Never> {
        var url = URL(string: everythingURL)!
        
        let queryItems = [URLQueryItem(name: "q", value: query),
                          URLQueryItem(name: "apiKey", value: configuration.newsApiKey),
                          URLQueryItem(name: "language", value: "en"),
                          URLQueryItem(name: "sortBy", value: "publishedAt")]
        url.appending(queryItems)
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsEverythingResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .eraseToAnyPublisher()
    }
    
    // MARK: Dividend Tracker
    func getCurrentSharePrices(stocks: [PortfolioStock]) -> AnyPublisher<[Double], Never> {
        let publisherOfPublishers = Publishers.Sequence<[AnyPublisher<Double, Never>], Never>(sequence: stocks.map(getCurrentSharePrice))
        return publisherOfPublishers.flatMap { $0 }.collect().eraseToAnyPublisher()
    }
    
    func getCurrentSharePrice(portfolioStock: PortfolioStock) -> AnyPublisher<Double, Never> {
        let urlString = currentStockPriceURL
            .replacingOccurrences(of: "{company}", with: portfolioStock.ticker)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CurrentSharePriceResponse.self, decoder: Current.decoder)
            .replaceError(with: .noResponse)
            .map { $0.price }
            .eraseToAnyPublisher()
    }
}
