//
//  SearchStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct SearchStock: Codable, Identifiable, Hashable {
    var id: String
    let ticker: String
    let fullName: String
    let marketCap: Double
}

extension SearchStock {
    static let mock = SearchStock(id: "com_NX6GzO", ticker: "AAPL", fullName: "Apple Inc", marketCap: 981382326400)
}
