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
            ListHeader(leadingText: "Name / Weight", trailingText: "Value / Unrealized gain")
            
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


