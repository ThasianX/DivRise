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
    
    static let sample = [HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100),
                         HoldingInfo(numOfShares: 100, avgCostPerShare: 100)
    ]
    
    static let sampleSharePrices: [Double] = [110, 95, 96, 91, 97, 102, 103, 104, 101, 99, 98, 105, 103, 106, 97]
}
