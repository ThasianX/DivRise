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
    
    let onCommit: (PortfolioStock, HoldingInfo) -> ()
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                Spacer()
                Text("Value / Unrealized gain")
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .font(.caption)
            .foregroundColor(Color("textColor"))
            
            if currentSharePrices.count == portfolioStocks.count {
                List(portfolioStocks.indexed(), id: \.1.self) { i, stock in
                    NavigationLink(destination: PositionDetailsView()) {
                        TrackerRow(stock: stock, holdingInfo: self.holdingsInfo[i], sharePrice: self.currentSharePrices[i])
                    }
                }
            }
        }
        .background(Color("modalBackground").edgesIgnoringSafeArea(.all))
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(portfolioStocks: [.mock, .mock, .mock], holdingsInfo: [.mock, .mock, nil], currentSharePrices: [27.32, 30, 26.3], onCommit: {_,_ in })
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
                            Text("-$\(-unrealizedGain(), specifier: "%.2f") (▼\(unrealizedGainPercent(), specifier: "%.2f")%)")
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
        (unrealizedGain() - 1.0) * 100
    }
}
