//
//  PortfolioSortHeader.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioSortHeader: View {
    @Binding var show: Bool
    let sortString: String
    
    var body: some View {
        HStack {
            Text("Sort:")
            Text("\(sortString) ▼")
            .bold()
                .onTapGesture {
                    self.show = true
            }
            Spacer()
        }
        .foregroundColor(Color("textColor"))
        .font(.caption)
        .padding(.leading, 20.0)
    }
}
