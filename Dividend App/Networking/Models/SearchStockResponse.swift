//
//  SearchStockResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct SearchStockResponse: Codable {
    let bestMatches: [BestMatch]
    
    // MARK: - BestMatch
    struct BestMatch: Codable {
        let symbol, name, type, region: String
        let marketOpen, marketClose, timezone, currency: String
        let matchScore: String

        enum CodingKeys: String, CodingKey {
            case symbol = "1. symbol"
            case name = "2. name"
            case type = "3. type"
            case region = "4. region"
            case marketOpen = "5. marketOpen"
            case marketClose = "6. marketClose"
            case timezone = "7. timezone"
            case currency = "8. currency"
            case matchScore = "9. matchScore"
        }
    }
}


extension SearchStockResponse {
    static let noResponse = SearchStockResponse(
        bestMatches: []
    )
}
