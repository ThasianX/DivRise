//
//  TrackerRow.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct TrackerRow: View {
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let sharePrice: Double
    let portfolioValue: Double
    
    private var costBasis: Double {
        holdingInfo!.numOfShares * holdingInfo!.avgCostPerShare
    }
    
    private var value: Double {
        holdingInfo!.numOfShares * sharePrice
    }
    
    private var unrealizedGain: Double {
        value - costBasis
    }
    
    private var unrealizedGainPercent: Double {
        ((value / costBasis) - 1.0) * 100
    }
    
    private var portfolioWeight: Double {
        (value / portfolioValue) * 100
    }
    
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
                    Text("\(portfolioWeight, specifier: "%.2f")%")
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
                        Text("$\(value, specifier: "%.2f")")
                            .font(.callout)
                            .foregroundColor(Color("textColor"))
                        if unrealizedGain >= 0 {
                            Text("+$\(unrealizedGain, specifier: "%.2f") (▲\(unrealizedGainPercent, specifier: "%.2f")%)")
                                .font(.footnote)
                                .foregroundColor(Color.green)
                        } else {
                            Text("-$\(-unrealizedGain, specifier: "%.2f") (▼\(-unrealizedGainPercent, specifier: "%.2f")%)")
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
}
