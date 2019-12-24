//
//  SearchStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct SearchStock: Codable, Equatable {
    let ticker: String
    let fullName: String
    let marketCap: Double
}
