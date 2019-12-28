//
//  Color+DarkMode.swift
//  Dividend App
//
//  Created by Kevin Li on 12/27/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

extension Color {

    static let lightBackgroundColor = Color(white: 1.0)

    static let darkBackgroundColor = Color(white: 0.0)

    static func backgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return lightBackgroundColor
        } else {
            return darkBackgroundColor
        }
    }
    
    static func textColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return darkBackgroundColor
        } else {
            return lightBackgroundColor
        }
    }
}
