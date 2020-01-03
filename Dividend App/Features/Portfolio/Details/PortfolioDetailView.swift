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
                        Text(self.portfolioStock.fullName)
                            .font(.subheadline)
                        Spacer()
                        Button(action: {
                            self.selectedPeriod = (self.selectedPeriod == "annual") ? "quarter" : "annual"
                            self.onPeriodChange()
                        }) {
                            Text(self.selectedPeriod.capitalized)
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                ScrollView(.vertical, showsIndicators: false) {
                        if self.attributeValues.count > 0 {
                            ZStack {
                                ActivityIndicator()
                                    .animated(false)
                                
                                VStack {
                                    CurrentDetailStockRow(attributeNames: self.getAbbreviatedNames(), attributeValues: self.getCurrentValues())
                                    
                                    CardDetailStockRow(selectedAttributeIndex: self.$selectedAttributeIndex, abbreviatedNames: self.getAbbreviatedNames(), fullNames: self.getFullNames(), descriptions: self.getDescriptions(), records: self.records, sharePriceRecords: self.sharePriceRecords, attributeValues: self.attributeValues)
                                }
                            }
                        } else {
                            Spacer()
                            HStack {
                                Spacer()
                                ActivityIndicator()
                                    .animated(true)
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        if self.stockNews.count > 0 {
                            ZStack {
                                ActivityIndicator()
                                    .animated(false)
                                
                                StockNewsView(showingSafari: self.$showingSafari, url: self.$url, stockNews: self.stockNews)
                                
                            }
                        } else {
                            Spacer()
                            HStack {
                                Spacer()
                                ActivityIndicator()
                                    .animated(true)
                                Spacer()
                            }
                            Spacer()
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
        }
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
        PortfolioDetailView(selectedPeriod: .constant("annual"), selectedAttributeIndex: .constant(nil), attributeNames: .constant(["sharePrices", "peRatios", "pegRatios", "payoutRatios", "dividendYields", "dividendPerShares", "fcfes", "netDebtToEBITDAs", "grahamNumbers", "debtToEquitys", "operatingProfitMargins", "debtToCapitalRatios"]), showingSafari: .constant(false), url: .constant(URL(string: "https://www.google.com/")!), portfolioStock: PortfolioStock(ticker: "AAPL", fullName: "Apple Inc.", startingDividend: 2.0, currentDividend: 2.92, growth: 46.0), records: [Record(month: "Sep", day: nil, year: "2019"), Record(month: "Sep", day: nil, year: "2018")], sharePriceRecords: [Record(month: "Sep", day: "2", year: "2019"), Record(month: "Sep", day: "3", year: "2018")], attributeValues: [[2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6], [2,6]], onPeriodChange: { }, stockNews: [StockNews(title: "5 Stocks Analysts Recommend Heading Into 2020", source: "Benzinga", image: URL(string: "https://cdn2.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/chart-1905225_1280_5.jpg")!, url: URL(string: "https://www.benzinga.com/trading-ideas/long-ideas/20/01/15041911/5-stocks-analysts-recommend-heading-into-2020")!, publishedSince: "3d ago"), StockNews(title: "5 Stocks Analysts Recommend Heading Into 2020", source: "Benzinga", image: URL(string: "https://cdn2.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/chart-1905225_1280_5.jpg")!, url: URL(string: "https://www.benzinga.com/trading-ideas/long-ideas/20/01/15041911/5-stocks-analysts-recommend-heading-into-2020")!, publishedSince: "3d ago"), StockNews(title: "5 Stocks Analysts Recommend Heading Into 2020", source: "Benzinga", image: URL(string: "https://cdn2.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/chart-1905225_1280_5.jpg")!, url: URL(string: "https://www.benzinga.com/trading-ideas/long-ideas/20/01/15041911/5-stocks-analysts-recommend-heading-into-2020")!, publishedSince: "3d ago"), StockNews(title: "5 Stocks Analysts Recommend Heading Into 2020", source: "Benzinga", image: URL(string: "https://cdn2.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/chart-1905225_1280_5.jpg")!, url: URL(string: "https://www.benzinga.com/trading-ideas/long-ideas/20/01/15041911/5-stocks-analysts-recommend-heading-into-2020")!, publishedSince: "3d ago")])
    }
}
