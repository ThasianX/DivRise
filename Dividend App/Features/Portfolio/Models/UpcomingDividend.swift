//
//  UpcomingDividend.swift
//  Dividend App
//
//  Created by Kevin Li on 12/31/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct UpcomingDividend: Codable, Hashable {
    let ticker: String
    let date: Date
}

extension UpcomingDividend {
    static let mock = UpcomingDividend(ticker: "AAPL", date: Date())
}
