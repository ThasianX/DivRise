//
//  PortfolioDetailContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIX

struct PortfolioDetailContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @ObservedObject var detailState = DetailState()
    
    let portfolioStock: PortfolioStock
    
    var body: some View {
        PortfolioDetailView(selectedPeriod: $detailState.selectedPeriod, selectedDetailAttribute: $detailState.selectedDetailAttribute, attributeNames: $detailState.attributeOrder, portfolioStock: portfolioStock, records: getRecords(), attributeValues: getAttributeValues())
        .onAppear(perform: loadDetailStock)
    }
    
    private func loadDetailStock() {
        store.send(setCurrentDetailStock(identifier: portfolioStock.ticker, period: detailState.selectedPeriod))
    }
    
    private func getRecords() -> [Record] {
        if let detailStock = store.state.currentDetailStock {
            return detailStock.records
        } else {
            return []
        }
    }
    
    private func getAttributeValues() -> [[Double]] {
        if let detailStock = store.state.currentDetailStock {
            return detailState.attributeOrder.compactMap {
                detailStock.details[$0]!
            }
        } else {
            return []
        }
    }
}
