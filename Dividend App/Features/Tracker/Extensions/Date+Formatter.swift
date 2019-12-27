//
//  Formatter.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static let mediumStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
}

extension Date {
    var monthMedium: String {
        return Formatter.monthMedium.string(from: self)
    }
    
    var year: String {
        return Formatter.year.string(from: self)
    }
    
    var mediumStyle: String {
        return Formatter.mediumStyle.string(from: self)
    }
}
