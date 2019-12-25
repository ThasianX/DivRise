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
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.clear)
                    .frame(width: 50, height: 50)
            } else {
                URLImage(URL(string: stock.image)!) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                .frame(width: 40, height: 40)
            }
            
            
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.headline)
                
                Text(stock.fullName)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(stock.marketCap)
        }
        .padding()
    }
}

struct SearchStockRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchStockRow(stock: .mock)
    }
}
