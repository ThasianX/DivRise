//
//  PortfolioDetailContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import Combine

struct PortfolioDetailContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State var selectedPeriod = "annual"
    
    let ticker: String
    
    
    var body: some View {
        PortfolioDetailView(detailStock: store.state.currentDetailStock)
    }
    
    private func createInitialDetails() {
        // Initial: payout ratio, fcfe, net debt to ebitda ratio, pe ratio, dividend yield, graham number, dividend per share, ROIC, debt to equity, operating profit margin, asset turnover ratio, debt to capital ratio, PEG ratio
        store.send(setCurrentDetailStock(identifier: ticker, period: selectedPeriod))
    }
}
