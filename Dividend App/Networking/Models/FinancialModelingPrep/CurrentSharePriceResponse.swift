//
//  CurrentSharePriceResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

struct CurrentSharePriceResponse: Codable, Hashable {
    let symbol: String
    let price: Double
}

extension CurrentSharePriceResponse {
    static let noResponse = CurrentSharePriceResponse(symbol: "", price: 0.0)
}
