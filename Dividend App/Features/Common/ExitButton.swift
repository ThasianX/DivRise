//
//  ExitButton.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct ExitButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = false
        }) {
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
            }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ExitButton_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton(show: .constant(true))
    }
}
