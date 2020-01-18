//
//  PortfolioView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @Binding var showingDetail: Bool
    @Binding var selectedIndex: Int
    @Binding var showingSortActions: Bool
    
    let portfolioStocks: [PortfolioStock]
    let sortString: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Portfolio")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("textColor"))
                    
                    Text("\(portfolioStocks.count) Stocks")
                        .foregroundColor(.gray)
                    //                    Text("\(PortfolioStock.sample.count) Stocks")
                    //                        .foregroundColor(.gray)
                    
                }
                Spacer()
            }
            .padding(.leading, 60.0)
            
            Spacer()
                .frame(height: 20)
            PortfolioSortHeader(show: $showingSortActions, sortString: sortString)
                .disabled(portfolioStocks.isEmpty ? true : false)
            
            if portfolioStocks.isEmpty {
                //                List {
                //                    ForEach(PortfolioStock.sample.indexed(), id: \.1.self) { index, stock in
                //                        Button(action: {
                //                            self.selectedIndex = index
                //                            self.showingDetail.toggle()
                //                        }) {
                //                            PortfolioStockRow(portfolioStock: stock)
                //                        }
                //                    }
                //                }
                
                ZStack {
                    Text("Add stocks to display")
                        .foregroundColor(Color("textColor"))
                        .font(.headline)
                        .italic()
                    
                    List {
                        ForEach(PortfolioStock.sample.indexed(), id: \.1.self) { index, stock in
                            PortfolioStockRow(portfolioStock: stock)
                        }
                    }
                    .opacity(0.5)
                    .disabled(true)
                }
            } else {
                List {
                    ForEach(portfolioStocks.indexed(), id: \.1.self) { index, stock in
                        Button(action: {
                            self.selectedIndex = index
                            self.showingDetail.toggle()
                        }) {
                            PortfolioStockRow(portfolioStock: stock)
                        }
                    }
                }
            }
        }
        .padding(.top, 70)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showingDetail: .constant(false), selectedIndex: .constant(0), showingSortActions: .constant(false), portfolioStocks: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], sortString: SortDirection.sortString(sort: PortfolioSortState.name, direction: SortDirection.up))
            .background(Color("background"))
    }
}
