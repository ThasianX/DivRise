//
//  Environment.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation
import Combine

struct Environment {
    var decoder = JSONDecoder()
    var encoder = JSONEncoder()
    var files = FileManager.default
}

var Current = Environment()
