//
//  StockDetailRow.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct StockDetailPopup: View {
    let stock: PortfolioStock
    
    var body: some View {
        HStack {
            URLImage(URL(string: stock.image)!) { proxy in
                proxy.image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }
            .cornerRadius(8)
            .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.subheadline)
                Text(stock.fullName)
            }
            .foregroundColor(Color("textColor"))
            
            Spacer()
            
            Image(systemName: "chevron.up.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
        }
        .padding()
        .embedInRectangle()
        .contentShape(Rectangle())
    }
}
