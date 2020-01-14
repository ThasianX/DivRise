//
//  Formatter.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension DateFormatter {
    convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static let mediumStyleNoDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static let fullString: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let mediumStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    static let utcStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var monthMedium: String {
        return Formatter.monthMedium.string(from: self)
    }
    
    var day: String {
        return Formatter.day.string(from: self)
    }
    
    var year: String {
        return Formatter.year.string(from: self)
    }
    
    var mediumStyleNoDay: String {
        return Formatter.mediumStyleNoDay.string(from: self)
    }
    
    var mediumStyle: String {
        return Formatter.mediumStyle.string(from: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func getHour() -> Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    func getMinute() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    func dateAtTime(hour: Int, minute: Int) -> Date {
         let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        return calendar.date(from: dateComponents)!
    }
}

extension String {
    var toLocalTime: Date? {
        return Formatter.utcStyle.date(from: self)
    }
    
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}
