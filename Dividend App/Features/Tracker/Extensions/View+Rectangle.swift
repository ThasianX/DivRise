//
//  View+Rectangle.swift
//  Dividend App
//
//  Created by Kevin Li on 1/14/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

extension View {
    func embedInRectangle() -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}
