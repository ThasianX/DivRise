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
    @Binding var selectedDetailAttribute: String?
    @Binding var attributeNames: [String]
    
    let portfolioStock: PortfolioStock
    let records: [Record]
    let attributeValues: [[Double]]
    
    var body: some View {
        VStack {
            HStack {
                Text(portfolioStock.ticker)
                    .font(.largeTitle)
                Text(portfolioStock.fullName)
                    .font(.subheadline)
                Button(action: {
                    self.selectedPeriod = (self.selectedPeriod == "annual") ? "quarter" : "annual"
                }) {
                    Text(self.selectedPeriod.capitalized)
                }
            }
            
            if attributeValues.count > 0 {
                ActivityIndicator()
                .animated(false)
                
                CurrentDetailStockRow(attributeNames: getAbbreviatedNames(), attributeValues: getCurrentValues())
                
                CardDetailStockRow(abbreviatedNames: getAbbreviatedNames(), fullNames: getFullNames(), records: records, attributeValues: attributeValues)
                
            } else {
                ActivityIndicator()
                .animated(true)
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
        return values
    }
    
}

//struct PortfolioDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioDetailView(selectedPeriod: <#Binding<String>#>, detailStock: nil)
//    }
//}
