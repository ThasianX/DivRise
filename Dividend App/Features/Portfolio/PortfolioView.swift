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
    
    var portfolioStocks: [PortfolioStock]
    var onDelete: (IndexSet) -> Void
    var onMove: (IndexSet, Int) -> Void
    
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
                }
                Spacer()
            }
            .padding(.leading, 60.0)
            
            List {
                ForEach(portfolioStocks.indexed(), id: \.1.self) { index, stock in
                    Button(action: {
                        self.selectedIndex = index
                        self.showingDetail.toggle()
                    }) {
                        PortfolioStockView(portfolioStock: stock)
                    }
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
        }
        .padding(.top, 70)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showingDetail: .constant(false), selectedIndex: .constant(0), portfolioStocks: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], onDelete: { _ in }, onMove: { _, _ in })
            .background(Color("background"))
    }
}
