//
//  SearchStockView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct SearchStockView: View {
    @Binding var query: String
    @Binding var showingAlert: Bool
    @Binding var selectedStock: SearchStock?
    
    let searchedStocks: [SearchStock]
    let onCommit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
                TextField("Search stocks, funds....", text: $query, onCommit: onCommit)
                
                if searchedStocks.isEmpty {
                    Text("Search Something")
                } else {
                    List(searchedStocks, id: \.self) { stock in
                        SearchStockRow(stock: stock)
                            .onTapGesture {
                                self.selectedStock = stock
                                self.showingAlert = true
                        }
                    }
                }
            }
        .padding()
    }
}

