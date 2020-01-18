//
//  StockInfoRow.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct StockInfoRow: View {
    let attribute: String
    let value: String
    var valueColor: Color? = nil
    
    var body: some View {
        HStack {
            Text(attribute)
                .foregroundColor(Color("textColor"))
                .font(.callout)
            Spacer()
            Text(value)
                .bold()
                .foregroundColor((valueColor == nil) ? Color("textColor") : valueColor)
        }
    }
}
