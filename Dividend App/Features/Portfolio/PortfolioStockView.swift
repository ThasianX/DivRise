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
            VStack(alignment: .leading) {
                Text(portfolioStock.ticker)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("textColor"))
                
                Text(portfolioStock.fullName)
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(String(format: "%.2f", portfolioStock.currentDividend))")
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .padding(.trailing, 10)
                
                Text("\(signForStock(growth: portfolioStock.growth))\(String(format: "%.2f", portfolioStock.growth))%")
                .font(.system(size: 14))
                    .foregroundColor(Color("textColor"))
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                    .background(backgroundColor(growth: portfolioStock.growth))
                    .cornerRadius(4)
            }
        }
    }
    
    private func signForStock(growth: Double) -> String {
        if growth >= 0 {
            return "+"
        }
        return ""
    }
    
    private func backgroundColor(growth: Double) -> Color {
        if growth >= 0 {
            return .green
        }
        return .red
    }
}

