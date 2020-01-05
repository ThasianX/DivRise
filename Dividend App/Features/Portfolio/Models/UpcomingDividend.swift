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
    
    static let sample = [Date().addingTimeInterval(10020),
                         Date().addingTimeInterval(123123),
                         Date().addingTimeInterval(123121),
                         Date().addingTimeInterval(111222),
                         Date().addingTimeInterval(333333),
                         Date().addingTimeInterval(444444),
                         Date().addingTimeInterval(422322),
                         Date().addingTimeInterval(112111),
                         Date().addingTimeInterval(313133),
                         Date().addingTimeInterval(5646454),
                         Date().addingTimeInterval(7272722),
                         Date().addingTimeInterval(1344444),
                         Date().addingTimeInterval(888888),
                         Date().addingTimeInterval(777777),
                         Date().addingTimeInterval(666666)]
}
