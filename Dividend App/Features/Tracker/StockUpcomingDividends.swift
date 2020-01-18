//
//  StockUpcomingDividends.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct StockUpcomingDividends: View {
    let months: [String]
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo
    
    private var dividend: Double {
        let annualIncome = stock.currentDividend * holdingInfo.numOfShares
        
        if stock.frequency == "Quarterly" {
            return annualIncome / 4
        } else if stock.frequency == "Semi-Annual" {
            return annualIncome / 2
        } else {
            return annualIncome / 12
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upcoming Dividends")
                .font(.headline)
                .foregroundColor(Color("textColor"))
            CustomDivider()
            
            VStack(alignment: .leading, spacing: 20) {
                ForEach(months, id: \.self) { month in
                    StockInfoRow(attribute: month, value: "$\(String(format: "%.2f", self.dividend))", valueColor: .green)
                }
            }
        }
        .padding()
        .embedInRectangle()
    }
}
