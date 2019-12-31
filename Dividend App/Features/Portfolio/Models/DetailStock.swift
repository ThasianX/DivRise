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
    let sharePriceRecords: [Record]
    let details: [String: [Double]]
}
