//
//  StockHistoricalPriceResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/31/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct StockHistoricalPriceResponse: Codable, Hashable {
    let symbol: String
    let historical: [Historical]
    
    // MARK: - Historical
    struct Historical: Codable, Hashable {
        let date: String
        let close: Double
    }
}


extension StockHistoricalPriceResponse {
    static let noResponse = StockHistoricalPriceResponse(
        symbol: "", historical: []
    )
}
