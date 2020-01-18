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
    @Binding var editMode: EditMode
    @Binding var showStockDetail: Bool
    @Binding var numOfShares: String
    @Binding var avgCostPerShare: String
    
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let currentSharePrice: Double
    let onCommit: (PortfolioStock) -> Void
    
    let upcomingMonths: [String]
    
    var body: some View {
        ZStack {
            Color("modalBackground").edgesIgnoringSafeArea(.all)
            VStack {
                StockDetailRow(stock: stock)
                    .onTapGesture {
                        self.showStockDetail = true
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        if holdingInfo == nil || editMode == .active {
                            HoldingInfoForm(editMode: $editMode, numOfShares: $numOfShares, avgCostPerShare: $avgCostPerShare, stock: stock, holdingInfo: holdingInfo, onCommit: onCommit)
                        } else {
                            StockInfoRectange(stock: stock, holdingInfo: holdingInfo!, currentSharePrice: currentSharePrice)
                            StockUpcomingDividends(months: upcomingMonths, stock: stock, holdingInfo: holdingInfo!)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct HoldingInfoForm: View {
    @Binding var editMode: EditMode
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
            DarkTextField(placeholder: (holdingInfo == nil) ? "0.0" : "\(holdingInfo!.numOfShares, specifier: "%.2f")", input: $numOfShares)
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
                DarkTextField(placeholder: (holdingInfo == nil) ? "0.0" : "\(holdingInfo!.avgCostPerShare, specifier: "%.2f")", input: $avgCostPerShare)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            Spacer()
                .frame(height: 20)
            
            Button(action: {
                withAnimation {
                    if !(self.numOfShares.isEmpty && self.avgCostPerShare.isEmpty) {
                        UIApplication.shared.endEditing(true)
                        self.editMode = .inactive
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
        .embedInRectangle()
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
        .embedInRectangle()
        .contentShape(Rectangle())
    }
}

struct StockInfoRectange: View {
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

struct StockInfoRow: View {
    let attribute: String
    let value: String
    var valueColor: Color? = nil
    
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
                    StockInfoRow(attribute: month, value: "$\(String(format: "%.2f", self.dividend))")
                }
            }
        }
        .padding()
        .embedInRectangle()
    }
}
