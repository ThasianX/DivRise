//
//  PortfolioView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    var portfolioStocks: [PortfolioStock]
    var onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(portfolioStocks, id: \.self) { stock in
                NavigationLink(destination: PortfolioDetailContainerView(ticker: stock.ticker)) {
                    PortfolioStockView(portfolioStock: stock)
                }
            }
            .onDelete(perform: onDelete)
        }
        
    }
}
