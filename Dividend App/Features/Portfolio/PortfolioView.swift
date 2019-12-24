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
            
            Text("$\(String(format: "%.2f",  portfolioStock.currentDividend))")
            
            if portfolioStock.growth > 1 {
                Text("\(String(format: "%.2f", portfolioStock.growth))%").foregroundColor(.green)
            } else {
                Text("\(String(format: "%.2f", portfolioStock.growth))%").foregroundColor(.red)
            }
            
        }
    }
}

struct PortfolioView: View {
    var portfolioStocks: [PortfolioStock]
    
    var body: some View {
        List(portfolioStocks) { stock in
            NavigationLink(destination: PortfolioDetailContainerView(ticker: stock.ticker)) {
                PortfolioStockView(portfolioStock: stock)
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(portfolioStocks: [PortfolioStock.mock, PortfolioStock.mock, PortfolioStock.mock, PortfolioStock.mock])
    }
}
