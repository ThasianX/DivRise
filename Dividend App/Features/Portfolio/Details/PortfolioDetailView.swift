//
//  PortfolioDetailView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct PortfolioDetailView: View {
    @Binding var selectedPeriod: String
    @Binding var selectedAttributeIndex: Int?
    @Binding var attributeNames: [String]
    @Binding var showingSafari: Bool
    @Binding var url: URL
    
    let portfolioStock: PortfolioStock
    let records: [Record]
    let sharePriceRecords: [Record]
    let attributeValues: [[Double]]
    let onPeriodChange: () -> Void
    let stockNews: [StockNews]
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
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
                    }
                    .padding()
                    
                    Divider()
                        .background(Color.white)
                    
                ScrollView(.vertical, showsIndicators: false) {
                        if self.attributeValues.count > 0 {
                                VStack {
                                    CurrentDetailStockRow(attributeNames: self.getAbbreviatedNames(), attributeValues: self.getCurrentValues())
                                    
                                    CardDetailStockRow(selectedAttributeIndex: self.$selectedAttributeIndex, abbreviatedNames: self.getAbbreviatedNames(), fullNames: self.getFullNames(), descriptions: self.getDescriptions(), records: self.records, sharePriceRecords: self.sharePriceRecords, attributeValues: self.attributeValues)
                                }
                        }
                        
                        if self.stockNews.count > 0 {
                            StockNewsView(showingSafari: self.$showingSafari, url: self.$url, stockNews: self.stockNews)
                        }
                    }
                }
                .frame(width: geometry.size.width)
                .blur(radius: self.selectedAttributeIndex == nil ? 0 : 40)
                .animation(.easeInOut)
            }
            if self.selectedAttributeIndex != nil {
                CardView(index: self.$selectedAttributeIndex, abbreviatedName: self.getAbbreviatedNames()[self.selectedAttributeIndex!], fullName: self.getFullNames()[self.selectedAttributeIndex!], description: self.getDescriptions()[self.selectedAttributeIndex!], records: self.records.reversed(), sharePriceRecords: self.sharePriceRecords.reversed(), values: self.attributeValues[self.selectedAttributeIndex!].reversed())
            }
        }
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func getFullNames() -> [String] {
        attributeNames.compactMap {
            DetailAttributes.full[$0]
        }
    }
    
    private func getAbbreviatedNames() -> [String] {
        attributeNames.compactMap {
            DetailAttributes.abbreviated[$0]
        }
    }
    
    private func getDescriptions() -> [String] {
        attributeNames.compactMap {
            DetailAttributes.descriptions[$0]
        }
    }
    
    private func getCurrentValues() -> [[Double]] {
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
    
}

struct PortfolioDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioDetailView(selectedPeriod: .constant("annual"), selectedAttributeIndex: .constant(nil), attributeNames: .constant(["sharePrices", "peRatios", "pegRatios", "payoutRatios", "dividendYields", "dividendPerShares", "fcfes", "netDebtToEBITDAs", "grahamNumbers", "debtToEquitys", "operatingProfitMargins", "debtToCapitalRatios"]), showingSafari: .constant(false), url: .constant(URL(string: "https://www.google.com/")!), portfolioStock: .mock, records: [.mock, .mock], sharePriceRecords: [Record(month: "Sep", day: "2", year: "2019"), Record(month: "Sep", day: "3", year: "2018")], attributeValues: [[2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6]], onPeriodChange: { }, stockNews: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock])
    }
}
