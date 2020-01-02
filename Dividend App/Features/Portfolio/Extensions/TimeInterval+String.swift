//
//  TimeInterval+String.swift
//  Dividend App
//
//  Created by Kevin Li on 1/1/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

extension TimeInterval {
    func timeIntervalAsString() -> String {
        let asInt = NSInteger(self)
        
        let s = asInt % 60
        let m = (asInt / 60) % 60
        let h = ((asInt / 3600))%24
        let d = (asInt / 86400)
        let w = d / 7
        
        var value = ""
        
        if w > 0 {
            value = "\(w)w"
        } else if d > 0 {
            value = "\(d)d"
        } else if h > 0 {
            value = "\(h)h"
        } else if m > 0 {
            value = "\(m)m"
        } else {
            value = "\(s)s"
        }
        
        value += " ago"
        
        return value
    }
    
}
