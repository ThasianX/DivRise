//
//  PortfolioView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioStockView: View {
    var portfolioStock: PortfolioStock
    
    var body: some View {
        HStack {
            Text(portfolioStock.ticker)
            
            Spacer()
            
            Text("$\(String(format: "%.2f", portfolioStock.currentDividend))")
            
            if portfolioStock.growth > 0 {
                Text("\(String(format: "%.2f", portfolioStock.growth))%").foregroundColor(.green)
            } else if portfolioStock.growth == 0{
                Text("0%").foregroundColor(.gray)
            } else {
                Text("\(String(format: "%.2f", portfolioStock.growth))%").foregroundColor(.red)
            }
             
        }
    }
}

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
