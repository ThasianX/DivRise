//
//  ListHeader.swift
//  Dividend App
//
//  Created by Kevin Li on 1/16/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct ListHeader: View {
    let leadingText: String
    let trailingText: String
    
    var body: some View {
        HStack {
            Text(leadingText)
            Spacer()
            Text(trailingText)
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .font(.caption)
        .foregroundColor(Color("textColor"))
    }
}
