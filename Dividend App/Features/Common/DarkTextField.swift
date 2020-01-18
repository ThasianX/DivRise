//
//  DarkTextField.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct DarkTextField: View {
    let placeholder: LocalizedStringKey
    @Binding var input: String
    var onCommit: () -> Void = { }
    
    var body: some View {
        TextField(placeholder, text: $input, onCommit: onCommit)
            .foregroundColor(Color.white)
            .colorScheme(.dark)
    }
}
