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
    
    var body: some View {
        VStack {
            HoldingsListHeader()
            
            if portfolioStocks.count == 0 {
                ZStack {
                    Text("Add stocks to display")
                        .foregroundColor(Color("textColor"))
                        .font(.headline)
                        .italic()
                    
                    List(PortfolioStock.sample.indexed(), id: \.1.self) { i, stock in
                        TrackerRow(stock: stock, holdingInfo: HoldingInfo.sample[i], sharePrice: HoldingInfo.sampleSharePrices[i])
                    }
                    .opacity(0.3)
                    .disabled(true)
                }
            } else {
                if currentSharePrices.count == portfolioStocks.count {
                    List(portfolioStocks.indexed(), id: \.1.self) { i, stock in
                        NavigationLink(destination: PositionDetailsContainerView(index: i)) {
                            TrackerRow(stock: stock, holdingInfo: self.holdingsInfo[i], sharePrice: self.currentSharePrices[i])
                        }
                    }
                }
            }
        }
        .background(Color("modalBackground").edgesIgnoringSafeArea(.all))
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(portfolioStocks: [.mock, .mock, .mock], holdingsInfo: [.mock, .mock, nil], currentSharePrices: [27.32, 30, 26.3])
    }
}

struct HoldingsListHeader: View {
    var body: some View {
        HStack {
            Text("Name")
            Spacer()
            Text("Value / Unrealized gain")
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .font(.caption)
        .foregroundColor(Color("textColor"))
    }
}

struct TrackerRow: View {
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let sharePrice: Double
    
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
                    .font(.headline)
                Text(stock.fullName)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            
            Spacer()
            
            if holdingInfo != nil {
                VStack(alignment: .trailing) {
                    if holdingInfo != nil {
                        Text("$\(value(), specifier: "%.2f")")
                            .font(.callout)
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
            }
        }
        .foregroundColor(Color("textColor"))
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
}
