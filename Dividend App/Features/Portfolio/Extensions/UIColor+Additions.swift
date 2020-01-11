//
//  UIColor+Random.swift
//  Dividend App
//
//  Created by Kevin Li on 1/9/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import UIKit

extension UIColor {
    static var randomDark: UIColor {
        let r:CGFloat  = .random(in: 0...0.4)
        let g:CGFloat  = .random(in: 0...0.4)
        let b:CGFloat  = .random(in: 0...0.4)
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
    
