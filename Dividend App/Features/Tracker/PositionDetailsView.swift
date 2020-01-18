//
//  PositionDetailsView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/12/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct PositionDetailsView: View {
    @Binding var editMode: EditMode
    @Binding var showStockDetail: Bool
    @Binding var numOfShares: String
    @Binding var avgCostPerShare: String
    
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let currentSharePrice: Double
    let onCommit: (PortfolioStock) -> Void
    
    let upcomingMonths: [String]
    
    var body: some View {
        ZStack {
            Color("modalBackground").edgesIgnoringSafeArea(.all)
            VStack {
                StockDetailPopup(stock: stock)
                    .onTapGesture {
                        self.showStockDetail = true
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        if holdingInfo == nil || editMode == .active {
                            HoldingInfoForm(editMode: $editMode, numOfShares: $numOfShares, avgCostPerShare: $avgCostPerShare, stock: stock, holdingInfo: holdingInfo, onCommit: onCommit)
                        } else {
                            HoldingDetails(stock: stock, holdingInfo: holdingInfo!, currentSharePrice: currentSharePrice)
                            StockUpcomingDividends(months: upcomingMonths, stock: stock, holdingInfo: holdingInfo!)
                        }
                    }
                }
                .keyboardResponsive()
            }
            .padding()
        }
    }
}


