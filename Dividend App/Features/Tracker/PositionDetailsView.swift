//
//  PositionDetailsView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct PositionDetailsView: View {
    @SwiftUI.Environment(\.editMode) var editMode
    @Binding var showStockDetail: Bool
    @Binding var numOfShares: String
    @Binding var avgCostPerShare: String
    
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let currentSharePrice: Double
    
    let onCommit: (PortfolioStock) -> Void
    
    var body: some View {
        ZStack {
            Color("modalBackground").edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                StockDetailRow(stock: stock)
                    .onTapGesture {
                        self.showStockDetail = true
                }
                if holdingInfo == nil || editMode?.wrappedValue == .active {
                    HoldingInfoForm(numOfShares: $numOfShares, avgCostPerShare: $avgCostPerShare, stock: stock, holdingInfo: holdingInfo, onCommit: onCommit)
                } else {
                    StockInfoRectange(stock: stock, holdingInfo: holdingInfo!, currentSharePrice: currentSharePrice)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct HoldingInfoForm: View {
    @SwiftUI.Environment(\.editMode) var editMode
    @Binding var numOfShares: String
    @Binding var avgCostPerShare: String
    
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let onCommit: (PortfolioStock) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Number of Shares")
                .font(.title)
                .foregroundColor(Color("textColor"))
            TextField((holdingInfo == nil) ? "0" : "\(holdingInfo!.numOfShares, specifier: "%.2f")", text: $numOfShares)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            Spacer()
                .frame(height: 20)
            
            Text("Average Cost Per Share")
                .font(.title)
                .foregroundColor(Color("textColor"))
            HStack {
                Text("$")
                    .font(.title)
                    .foregroundColor(Color("textColor"))
                TextField((holdingInfo == nil) ? "0.0" : "\(holdingInfo!.avgCostPerShare, specifier: "%.2f")", text: $avgCostPerShare)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            Spacer()
                .frame(height: 20)
            
            Button(action: {
                withAnimation {
                    if !(self.numOfShares.isEmpty && self.avgCostPerShare.isEmpty) {
                        self.editMode?.wrappedValue = .inactive
                        self.onCommit(self.stock)
                    }
                }
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

struct StockDetailRow: View {
    let stock: PortfolioStock
    
    var body: some View {
        HStack {
            URLImage(URL(string: stock.image)!) { proxy in
                proxy.image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            }
            .cornerRadius(8)
            .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.subheadline)
                Text(stock.fullName)
            }
            .foregroundColor(Color("textColor"))
            
            Spacer()
            
            Image(systemName: "chevron.up.circle.fill")
            .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.white, lineWidth: 2)
        )
        .contentShape(Rectangle())
    }
}

struct StockInfoRectange: View {
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo
    let currentSharePrice: Double
    
    var body: some View {
        VStack(spacing: 20) {
            StockInfoRow(attribute: "Shares", value: "\(holdingInfo.numOfShares)", valueColor: nil)
            StockInfoRow(attribute: "Avg Cost per Share", value: String(format: "$%.2f", holdingInfo.avgCostPerShare), valueColor: nil)
            StockInfoRow(attribute: "Cost Basis", value: String(format: "$%.2f", costBasis()), valueColor: nil)
            StockInfoRow(attribute: "Value", value: String(format: "$%.2f", value()), valueColor: nil)
            StockInfoRow(attribute: "Unrealized Gain", value: unrealizedGainString(), valueColor: unrealizedGainColor())
            StockInfoRow(attribute: "Dividend per Share", value: String(format: "$%.2f", dividendPerShare()), valueColor: nil)
            StockInfoRow(attribute: "Annual Dividend Income", value: String(format: "$%.2f", annualIncome()), valueColor: nil)
            StockInfoRow(attribute: "Yield on Cost", value: "\(String(format: "%.2f", yieldOnCost()))%", valueColor: nil)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.white, lineWidth: 2)
        )
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

struct StockInfoRow: View {
    let attribute: String
    let value: String
    let valueColor: Color?
    
    var body: some View {
        HStack {
            Text(attribute)
                .foregroundColor(Color("textColor"))
                .font(.callout)
            Spacer()
            Text(value)
                .bold()
                .foregroundColor((valueColor == nil) ? Color("textColor") : valueColor)
        }
    }
}
