//
//  PortfolioStockView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/28/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioStockView: View {
    var portfolioStock: PortfolioStock
    
    var body: some View {
            HStack {
                Text(portfolioStock.ticker)
                
                Spacer()
                
                Text("\(String(format: "%.2f", portfolioStock.currentDividend))")
                    .font(.headline)
                
                Text("\(signForStock(growth: portfolioStock.growth))\(String(format: "%.2f", portfolioStock.growth))%")
                    .font(.subheadline)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                    .background(backgroundColor(growth: portfolioStock.growth))
                    .cornerRadius(4)
            }
    }
    
    private func signForStock(growth: Double) -> String {
        if growth > 0 {
            return "+"
        } else {
            return ""
        }
    }
    
    private func backgroundColor(growth: Double) -> Color {
        if growth > 0 {
            return .green
        } else if growth == 0{
            return .gray
        } else {
            return .red
        }
    }
}

