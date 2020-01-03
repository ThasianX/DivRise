//
//  SearchStockRow.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct SearchStockRow: View {
    let stock: SearchStock
    
    var body: some View {
        HStack(alignment: .center) {
            if stock.image == "" {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.clear)
                    .frame(width: 40, height: 40)
            } else {
                URLImage(URL(string: stock.image)!) { proxy in
                    proxy.image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                .cornerRadius(8)
                .frame(width: 40, height: 40)
            }
            
            
            VStack(alignment: .leading) {
                Text(stock.ticker)
                .foregroundColor(Color("textColor"))
                    .font(.headline)
                
                Text(stock.fullName)
                .foregroundColor(Color("textColor"))
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(stock.marketCap)
            .foregroundColor(Color("textColor"))
            .bold()
        }
        .padding()
    }
}

struct SearchStockRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchStockRow(stock: .mock)
            .background(Color.black)
    }
}
