//
//  Portfolio.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation
import Combine

struct PortfolioStockService {
    func fetch(identifier: String, startingDividend: Double) -> AnyPublisher<PortfolioStock, Error> {
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
}
