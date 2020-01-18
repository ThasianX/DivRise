//
//  PortfolioDetailView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioDetailView: View {
    @Binding var selectedPeriod: String
    @Binding var selectedAttributeIndex: Int?
    @Binding var attributeNames: [String]
    @Binding var showingSafari: Bool
    @Binding var url: URL
    @Binding var show: Bool
    
    let portfolioStock: PortfolioStock
    let records: [Record]
    let sharePriceRecords: [Record]
    let attributeValues: [[Double]]
    let onPeriodChange: () -> Void
    let stockNews: [StockNews]
    
    private var fullNames: [String] {
        attributeNames.compactMap {
            DetailAttributes.full[$0]
        }
    }
    
    private var abbreviatedNames: [String] {
        attributeNames.compactMap {
            DetailAttributes.abbreviated[$0]
        }
    }
    
    private var descriptions: [String] {
        attributeNames.compactMap {
            DetailAttributes.descriptions[$0]
        }
    }
    
    private var currentValues: [[Double]] {
        var values = [[Double]]()
        var inner = [Double]()
        
        for (i, arr) in attributeValues.enumerated() {
            if i % 3 == 0 && !inner.isEmpty {
                values.append(inner)
                inner.removeAll()
            }
            inner.append(arr.first!)
        }
        values.append(inner)
        return values
    }
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(self.portfolioStock.ticker)
                        .font(.largeTitle)
                        .foregroundColor(Color("textColor"))
                    Text(self.portfolioStock.fullName)
                        .font(.subheadline)
                        .foregroundColor(Color("textColor"))
                    
                    Spacer()
                    
                    Button(action: {
                        self.selectedPeriod = (self.selectedPeriod == "annual") ? "quarter" : "annual"
                        self.onPeriodChange()
                    }) {
                        Text(self.selectedPeriod.capitalized)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.trailing, 8)
                    
                    ExitButton(show: $show)
                }
                .padding()
                
                Divider()
                    .background(Color.white)
                
                if self.attributeValues.count > 0 && self.stockNews.count > 0 {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            CurrentDetailStockRow(attributeNames: self.abbreviatedNames, attributeValues: self.currentValues)
                            
                            CardDetailStockRow(selectedAttributeIndex: self.$selectedAttributeIndex, abbreviatedNames: self.abbreviatedNames, fullNames: self.fullNames, descriptions: self.descriptions, records: self.records, sharePriceRecords: self.sharePriceRecords, attributeValues: self.attributeValues)
                            
                            StockNewsView(showingSafari: self.$showingSafari, url: self.$url, stockNews: self.stockNews)
                        }
                    }
                }
                
                Spacer()
            }
            .blur(radius: self.selectedAttributeIndex == nil ? 0 : 75)
            .animation(.easeInOut)
            
            if self.selectedAttributeIndex != nil {
                CardView(index: self.$selectedAttributeIndex, abbreviatedName: self.abbreviatedNames[self.selectedAttributeIndex!], fullName: self.fullNames[self.selectedAttributeIndex!], description: self.descriptions[self.selectedAttributeIndex!], records: self.records.reversed(), sharePriceRecords: self.sharePriceRecords.reversed(), values: self.attributeValues[self.selectedAttributeIndex!].reversed())
            }
        }
    }
}

struct PortfolioDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioDetailView(selectedPeriod: .constant("annual"), selectedAttributeIndex: .constant(nil), attributeNames: .constant(["sharePrices", "peRatios", "pegRatios", "payoutRatios", "dividendYields", "dividendPerShares", "fcfes", "netDebtToEBITDAs", "grahamNumbers", "debtToEquitys", "operatingProfitMargins", "debtToCapitalRatios"]), showingSafari: .constant(false), url: .constant(URL(string: "https://www.google.com/")!), show: .constant(true), portfolioStock: .mock, records: [.mock, .mock], sharePriceRecords: [Record(month: "Sep", day: "2", year: "2019"), Record(month: "Sep", day: "3", year: "2018")], attributeValues: [[2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6]], onPeriodChange: { }, stockNews: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock])
    }
}
