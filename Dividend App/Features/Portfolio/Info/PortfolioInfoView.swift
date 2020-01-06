//
//  PortfolioInfoView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/31/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioInfoView: View {
    @SwiftUI.Environment(\.editMode) var editMode
    @Binding var showEditInfo: Bool
    @Binding var selectedIndex: Int
    
    let portfolioStocks: [PortfolioStock]
    let upcomingDates: [Date]
    
    let onDelete: (IndexSet) -> Void
    let onMove: (IndexSet, Int) -> Void
    
    var body: some View {
        ZStack {
            BlurView(style: .systemMaterialDark)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                HStack {
                    TitleView()
                        .foregroundColor(Color("textColor"))
                        .blur(radius: editMode?.wrappedValue == EditMode.active ? 20 : 0)
                        .animation(.default)
                    
                    EditButton()
                        .padding()
                }
                
                if portfolioStocks.count == 0 || portfolioStocks.count != upcomingDates.count {
                    ZStack {
                        Text("Add stocks to display")
                            .foregroundColor(Color("textColor"))
                            .font(.headline)
                            .italic()
                        
                        List {
                            ForEach(PortfolioStock.sample.indexed(), id: \.1.self) { index, stock in
                                PortfolioInfoRow(stock: stock, date: UpcomingDividend.sample[index])
                            }
                        }
                        .opacity(0.3)
                        .disabled(true)
                    }
                } else {
                    ZStack {
                        List {
                            ForEach(portfolioStocks.indexed(), id: \.1.self) { index, stock in
                                Button(action: {
                                    self.selectedIndex = index
                                    self.showEditInfo = true
                                }) {
                                    PortfolioInfoRow(stock: stock, date: self.upcomingDates[index])
                                }
                            }
                            .onDelete(perform: onDelete)
                            .onMove(perform: onMove)
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
        PortfolioInfoView(showEditInfo: .constant(false), selectedIndex: .constant(0), portfolioStocks: [.mock, .mock, .mock, .mock, .mock, .mock], upcomingDates: [Date(), Date(), Date(), Date(), Date(), Date()], onDelete: { _ in }, onMove: { _, _ in})
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
