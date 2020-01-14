//
//  BasicDividendResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 1/13/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

struct BasicDividendResponse: Codable, Hashable {
    let symbol, exDate, paymentDate, recordDate: String
    let declaredDate: String
    let amount: Double
    let currency, description, frequency: String

    enum CodingKeys: String, CodingKey {
        case symbol, exDate, paymentDate, recordDate, declaredDate, amount, currency
        case description, frequency
    }
}


extension BasicDividendResponse {
    static let noResponse = BasicDividendResponse(symbol: "AAPL", exDate: "2017-08-10", paymentDate: "2017-08-17", recordDate: "2017-08-14", declaredDate: "2017-08-01", amount: 0.63, currency: "USD", description: "Apple declares dividend of .63", frequency: "Quarterly")
}
