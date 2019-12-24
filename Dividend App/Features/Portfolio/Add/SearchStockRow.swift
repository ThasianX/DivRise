//
//  SearchStockRow.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct SearchStockRow: View {
    let stock: SearchStock
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.headline)
                
                Text(stock.fullName)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text("$\(stock.marketCap.shortStringRepresentation)")
        }
    }
}

struct SearchStockRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchStockRow(stock: .mock)
    }
}
