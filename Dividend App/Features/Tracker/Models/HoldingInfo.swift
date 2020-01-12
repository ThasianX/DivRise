//
//  HoldingInfo.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

struct HoldingInfo: Codable, Hashable {
    let numOfShares: Double
    let avgCostPerShare: Double
}

extension HoldingInfo {
    static let mock = HoldingInfo(numOfShares: 2.26, avgCostPerShare: 28.12)
}
