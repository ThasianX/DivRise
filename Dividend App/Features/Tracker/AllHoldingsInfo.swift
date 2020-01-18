//
//  AllHoldingsInfo.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

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
