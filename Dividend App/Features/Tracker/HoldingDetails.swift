//
//  StockInfoRectangle.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct HoldingDetails: View {
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo
    let currentSharePrice: Double
    
    var body: some View {
        VStack(spacing: 20) {
            StockInfoRow(attribute: "Shares", value: "\(holdingInfo.numOfShares)")
            StockInfoRow(attribute: "Avg Cost per Share", value: String(format: "$%.2f", holdingInfo.avgCostPerShare))
            StockInfoRow(attribute: "Cost Basis", value: String(format: "$%.2f", costBasis()))
            StockInfoRow(attribute: "Value", value: String(format: "$%.2f", value()))
            StockInfoRow(attribute: "Unrealized Gain", value: unrealizedGainString(), valueColor: unrealizedGainColor())
            StockInfoRow(attribute: "Dividend per Share", value: String(format: "$%.2f", dividendPerShare()))
            StockInfoRow(attribute: "Annual Dividend Income", value: String(format: "$%.2f", annualIncome()))
            StockInfoRow(attribute: "Yield on Cost", value: "\(String(format: "%.2f", yieldOnCost()))%")
        }
        .padding()
        .embedInRectangle()
    }
    
    private func costBasis() -> Double{
        holdingInfo.numOfShares*holdingInfo.avgCostPerShare
    }
    
    private func value() -> Double {
        holdingInfo.numOfShares*currentSharePrice
    }
    
    private func unrealizedGain() -> Double {
        value() - costBasis()
    }
    
    private func unrealizedGainString() -> String {
        if unrealizedGain() >= 0 {
            return "+$\(String(format: "%.2f", unrealizedGain())) (▲\(String(format: "%.2f", unrealizedGainPercent()))%)"
        } else {
            return "-$\(String(format: "%.2f", -unrealizedGain())) (▼\(String(format: "%.2f", -unrealizedGainPercent()))%)"
        }
    }
    
    private func unrealizedGainColor() -> Color {
        if unrealizedGain() >= 0 {
            return .green
        } else {
            return .red
        }
    }
    
    private func unrealizedGainPercent() -> Double {
        ((value() / costBasis()) - 1.0) * 100
    }
    
    private func dividendPerShare() -> Double {
        stock.currentDividend
    }
    
    private func annualIncome() -> Double {
        dividendPerShare() * holdingInfo.numOfShares
    }
    
    private func yieldOnCost() -> Double {
        (annualIncome() / costBasis()) * 100
    }
}
