//
//  Portfolio.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation
import Combine

struct Request {
    func fetchPortfolioStock(identifier: String, startingDividend: Double) -> AnyPublisher<PortfolioStock, Error> {
        let urlString = "https://api-v2.intrinio.com/securities/{identifier}/dividends/latest".replacingOccurrences(of: "{identifier}", with: identifier)
        var url = URL(string: urlString)!
        
        let queryItems = [URLQueryItem(name: "api_key", value: "OjBjM2ZlMjE2NjdhYWQ4MGM4MTA2NzNkY2E0NWQ0ZTlm")]
        url.appending(queryItems)
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: PortfolioStockResponse.self, decoder: Current.decoder)
            .map { PortfolioStock(ticker: $0.security.ticker, startingDividend: startingDividend, currentDividend: $0.exDividend, growth: $0.exDividend / startingDividend)}
            .eraseToAnyPublisher()
    }
    
    func getSearchedStocks(query: String) -> AnyPublisher<[SearchStock], Error> {
        return searchStocks(query: query)
            .map { $0.companies }
            .flatMap { companies -> Publishers.MergeMany<AnyPublisher<SearchStock, Error>> in
                let stocks = companies.map { company -> AnyPublisher<SearchStock, Error> in
                    let ticker = company.ticker
                    let fullName = company.name
                    return self.fetchNumber(identifier: ticker, tag: "marketcap")
                        .flatMap { marketCap -> AnyPublisher<SearchStock, Error> in
                            return Just(SearchStock(ticker: ticker, fullName: fullName, marketCap: marketCap))
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
                }
                return Publishers.MergeMany(stocks)
        }
        .collect()
        .eraseToAnyPublisher()
    }
    
    func searchStocks(query: String) -> AnyPublisher<SearchStockResponse, Error> {
        let urlString = "https://api-v2.intrinio.com/companies/search"
        var url = URL(string: urlString)!
        
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "api_key", value: "OjBjM2ZlMjE2NjdhYWQ4MGM4MTA2NzNkY2E0NWQ0ZTlm")
        ]
        
        url.appending(queryItems)
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: SearchStockResponse.self, decoder: Current.decoder)
            .eraseToAnyPublisher()
    }
    
    func fetchNumber(identifier: String, tag: String) -> AnyPublisher<Double, Error> {
        let urlString = "https://api-v2.intrinio.com/companies/{identifier}/data_point/{tag}/number".replacingOccurrences(of: "{identifier}", with: identifier)
            .replacingOccurrences(of: "{tag}", with: tag)
        let url = URL(string: urlString)!
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: Double.self, decoder: Current.decoder)
            .eraseToAnyPublisher()
    }
}
