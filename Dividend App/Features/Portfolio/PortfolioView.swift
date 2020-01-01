//
//  PortfolioView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @Binding var showingDetail: Bool
    @Binding var selectedIndex: Int
    
    var portfolioStocks: [PortfolioStock]
    var onDelete: (IndexSet) -> Void
    var onMove: (IndexSet, Int) -> Void
    
    var body: some View {
        List {
            ForEach(portfolioStocks.indexed(), id: \.1.self) { index, stock in
                Button(action: {
                    self.selectedIndex = index
                    self.showingDetail.toggle()
                }) {
                    PortfolioStockView(portfolioStock: stock)
                }
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
    }
}
