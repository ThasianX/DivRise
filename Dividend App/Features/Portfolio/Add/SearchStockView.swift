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
        VStack {
            TextField("Search stocks, funds....", text: $query, onCommit: onCommit)
            
            List(searchedStocks) { stock in
                Button(action: {
                    self.showingAlert = true
                    self.selectedStock = stock
                }) {
                    SearchStockRow(stock: stock)
                }
            }
        }
    }
}

