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
    
    let portfolioStock: PortfolioStock
    let records: [Record]
    let attributeValues: [[Double]]
    let onPeriodChange: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Text(portfolioStock.ticker)
                        .font(.largeTitle)
                    Text(portfolioStock.fullName)
                        .font(.subheadline)
                    Spacer()
                    Button(action: {
                        self.selectedPeriod = (self.selectedPeriod == "annual") ? "quarter" : "annual"
                        self.onPeriodChange()
                    }) {
                        Text(self.selectedPeriod.capitalized)
                    }
                }
                .padding(30)
                
                if attributeValues.count > 0 {
                    ActivityIndicator()
                        .animated(false)
                    
                    CurrentDetailStockRow(attributeNames: getAbbreviatedNames(), attributeValues: getCurrentValues())
                    
                    CardDetailStockRow(selectedAttributeIndex: $selectedAttributeIndex, abbreviatedNames: getAbbreviatedNames(), fullNames: getFullNames(), descriptions: getDescriptions(), records: records, attributeValues: attributeValues)
                    
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
            .blur(radius: selectedAttributeIndex == nil ? 0 : 40)
            .animation(.easeInOut)
            
            if selectedAttributeIndex != nil {
                CardView(index: $selectedAttributeIndex, abbreviatedName: getAbbreviatedNames()[selectedAttributeIndex!], fullName: getFullNames()[selectedAttributeIndex!], description: getDescriptions()[selectedAttributeIndex!], records: records.reversed(), values: attributeValues[selectedAttributeIndex!].reversed())
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

//struct PortfolioDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioDetailView(selectedPeriod: <#Binding<String>#>, detailStock: nil)
//    }
//}
