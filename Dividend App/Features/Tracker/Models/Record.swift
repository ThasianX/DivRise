//
//  Record.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

public struct Record: Codable, Hashable {
    let month: String
    let day: String?
    let year: String
}

extension Record {
    static let mock = Record(month: "Jan", day: nil, year: "2018")
}
