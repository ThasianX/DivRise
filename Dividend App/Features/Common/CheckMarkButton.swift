//
//  CheckMarkButton.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct CheckMarkButton: View {
    let size: CGSize
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.action()
            }
        }) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: size.width, height: size.height)
                .foregroundColor(.green)
        }
    }
}

