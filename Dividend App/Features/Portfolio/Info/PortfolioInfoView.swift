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
        ZStack {
            BlurView(style: .systemMaterialDark)
            
            VStack(spacing: 0) {
                TitleView()
                    .foregroundColor(Color("textColor"))
                    .blur(radius: formShown ? 20 : 0)
                    .animation(.default)
                
                if upcomingDates.count != portfolioStocks.count {
                    ActivityIndicator()
                        .animated(true)
                } else {
                    ZStack {
                        ActivityIndicator()
                            .animated(false)
                        VStack(spacing: 5) {
                            ForEach(portfolioStocks.indexed(), id: \.1.self) { index, stock in
                                Button(action: {
                                    self.selectedIndex = index
                                    self.formShown = true
                                }) {
                                    PortfolioInfoRow(stock: stock, date: self.upcomingDates[index])
                                    Divider()
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct PortfolioInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioInfoView(selectedIndex: .constant(0), formShown: .constant(false), portfolioStocks: [.mock, .mock, .mock, .mock, .mock, .mock], upcomingDates: [Date(), Date(), Date(), Date(), Date(), Date()])
    }
}

struct TitleView: View {
    var body: some View {
        return VStack {
            HStack {
                Text("Dividend Info")
                    .foregroundColor(Color("textColor"))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
            }
        }.padding()
    }
}

struct PortfolioInfoRow: View {
    let stock: PortfolioStock
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .foregroundColor(Color("textColor"))
                    .font(.headline)
                    .fontWeight(.heavy)
                Text(stock.fullName)
                    .foregroundColor(Color("textColor"))
                    .font(.caption)
                    .lineLimit(nil)
            }
            
            Spacer()
            
            VStack {
                HStack(spacing: 0) {
                    Spacer()
                    Text("Starting dividend: ")
                        .foregroundColor(Color("textColor"))
                        .font(.footnote)
                    Text("$\(stock.startingDividend, specifier: "%.2f")")
                        .foregroundColor(Color("textColor"))
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                HStack(spacing: 0) {
                    Spacer()
                    Text("Next dividend: ")
                        .foregroundColor(Color("textColor"))
                        .font(.footnote)
                    Text(date.mediumStyle)
                        .foregroundColor(Color("textColor"))
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
    }
}
