//
//  TrackerView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct TrackerView: View {
    let portfolioStocks: [PortfolioStock]
    let holdingsInfo: [HoldingInfo?]
    let currentSharePrices: [Double]
    let portfolioValue: Double
    let portfolioCostBasis: Double
    
    var body: some View {
        VStack {
            AllHoldingsInfo(totalStocks: portfolioStocks.count, value: portfolioValue, costBasis: portfolioCostBasis)
            CustomDivider()
            
            HoldingsListHeader()
            
            if portfolioStocks.count == 0 {
                ZStack {
                    Text("Add stocks to display")
                        .foregroundColor(Color("textColor"))
                        .font(.headline)
                        .italic()
                    
                    List(PortfolioStock.sample.indexed(), id: \.1.self) { i, stock in
                        NavigationLink(destination: EmptyView()) {
                            TrackerRow(stock: stock, holdingInfo: HoldingInfo.sample[i], sharePrice: HoldingInfo.sampleSharePrices[i], portfolioValue: self.portfolioValue)
                        }
                        .colorScheme(.dark)
                    }
                    .opacity(0.3)
                    .disabled(true)
                }
            } else {
                if currentSharePrices.count == portfolioStocks.count {
                    List(portfolioStocks.indexed(), id: \.1.self) { i, stock in
                        NavigationLink(destination: PositionDetailsContainerView(index: i)) {
                            TrackerRow(stock: stock, holdingInfo: self.holdingsInfo[i], sharePrice: self.currentSharePrices[i], portfolioValue: self.portfolioValue)
                        }
                        .colorScheme(.dark)
                    }
                }
            }
        }
        .background(Color("modalBackground").edgesIgnoringSafeArea(.all))
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(portfolioStocks: [.mock, .mock, .mock], holdingsInfo: [.mock, .mock, nil], currentSharePrices: [27.32, 30, 26.3], portfolioValue: 500, portfolioCostBasis: 450)
    }
}

struct CustomDivider: View {
    let color: Color = .white
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct AllHoldingsInfo: View {
    let totalStocks: Int
    let value: Double
    let costBasis: Double
    
    private var unrealizedGain: Double {
        value - costBasis
    }
    
    private var unrealizedGainPercent: Double {
        ((value / costBasis) - 1.0) * 100
    }
    
    var body: some View {
        HStack {
            Text("Total(\(totalStocks))")
                .foregroundColor(Color("textColor"))
                .font(.headline)
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(value, specifier: "%.2f")")
                    .foregroundColor(Color("textColor"))
                    .bold()
                
                if unrealizedGain >= 0 {
                    Text("+$\(unrealizedGain, specifier: "%.2f") (▲\(unrealizedGainPercent, specifier: "%.2f")%)")
                        .bold()
                        .foregroundColor(Color.green)
                } else {
                    Text("-$\(-unrealizedGain, specifier: "%.2f") (▼\(-unrealizedGainPercent, specifier: "%.2f")%)")
                        .bold()
                        .foregroundColor(Color.red)
                }
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

struct HoldingsListHeader: View {
    var body: some View {
        HStack {
            Text("Name / Weight")
            Spacer()
            Text("Value / Unrealized gain")
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .font(.caption)
        .foregroundColor(Color("textColor"))
    }
}

struct TrackerRow: View {
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let sharePrice: Double
    let portfolioValue: Double
    
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
                HStack {
                    Text(stock.ticker)
                        .font(.caption)
                    Text(stock.fullName)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                
                if holdingInfo != nil {
                    Text("\(portfolioWeight(), specifier: "%.2f")%")
                        .font(.footnote)
                } else {
                    Text("N/A")
                        .font(.footnote)
                }
            }
            .foregroundColor(Color("textColor"))
            
            Spacer()
            
            if holdingInfo != nil {
                VStack(alignment: .trailing) {
                    if holdingInfo != nil {
                        Text("$\(value(), specifier: "%.2f")")
                            .font(.callout)
                            .foregroundColor(Color("textColor"))
                        if unrealizedGain() >= 0 {
                            Text("+$\(unrealizedGain(), specifier: "%.2f") (▲\(unrealizedGainPercent(), specifier: "%.2f")%)")
                                .font(.footnote)
                                .foregroundColor(Color.green)
                        } else {
                            Text("-$\(-unrealizedGain(), specifier: "%.2f") (▼\(-unrealizedGainPercent(), specifier: "%.2f")%)")
                                .font(.footnote)
                                .foregroundColor(Color.red)
                        }
                    }
                }
            } else {
                Text("N/A")
                    .foregroundColor(Color("textColor"))
            }
        }
    }
    
    private func costBasis() -> Double{
        holdingInfo!.numOfShares*holdingInfo!.avgCostPerShare
    }
    
    private func value() -> Double {
        holdingInfo!.numOfShares*sharePrice
    }
    
    private func unrealizedGain() -> Double {
        value() - costBasis()
    }
    
    private func unrealizedGainPercent() -> Double {
        ((value() / costBasis()) - 1.0) * 100
    }
    
    private func portfolioWeight() -> Double {
        (value() / portfolioValue) * 100
    }
}
