//
//  PortfolioInfoView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/31/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct PortfolioInfoView: View {
    @Binding var selectedIndex: Int
    @Binding var formShown: Bool
    
    var portfolioStocks: [PortfolioStock]
    let upcomingDates: [Date]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Portfolio Info")
                .font(.system(size: 30))
            
            if upcomingDates.count != portfolioStocks.count {
                ActivityIndicator()
                    .animated(true)
            } else {
                ActivityIndicator()
                    .animated(false)
                List(portfolioStocks.indexed(), id: \.1.self) { index, stock in
                    Button(action: {
                        self.selectedIndex = index
                        self.formShown = true
                    }) {
                        PortfolioInfoRow(stock: stock, date: self.upcomingDates[index])
                    }
                }
                .transition(.identity)
                .animation(nil)
            }
        }
    }
}

struct PortfolioInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioInfoView(selectedIndex: .constant(0), formShown: .constant(false), portfolioStocks: [.mock, .mock, .mock, .mock, .mock, .mock], upcomingDates: [Date(), Date(), Date(), Date(), Date(), Date()])
    }
}

struct PortfolioInfoRow: View {
    let stock: PortfolioStock
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text(stock.fullName)
                    .font(.caption)
                    .lineLimit(nil)
            }
            
            Spacer()
            
            VStack {
                HStack(spacing: 0) {
                    Text("Starting dividend: ")
                        .font(.footnote)
                    Text("$\(stock.startingDividend, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                HStack(spacing: 0) {
                    Text("Next dividend: ")
                        .font(.footnote)
                    Text(date.mediumStyle)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
