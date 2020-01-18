//
//  EditMode+Custom.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

extension EditMode {
    var title: String {
        self == .active ? "Done" : "Edit"
    }
    
    mutating func toggle() {
        self = (self == .active) ? .inactive : .active
    }
}
