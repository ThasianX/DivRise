//
//  DetailStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct DetailStock: Codable, Hashable {
    let records: [Record]
    let payoutRatios: [Double]
    let fcfes: [Double]
    let netDebtToEBITDAs: [Double]
    let peRatios: [Double]
    let dividendYields: [Double]
    let grahamNumbers: [Double]
    let dividendPerShares: [Double]
    let roics: [Double]
    let debtToEquitys: [Double]
    let operatingProfitMargins: [Double]
    let assetTurnoverRatios: [Double]
    let debtToCapitalRatios: [Double]
    let pegRatios: [Double]
}
