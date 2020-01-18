//
//  HoldingsInfoForm.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct HoldingInfoForm: View {
    @Binding var editMode: EditMode
    @Binding var numOfShares: String
    @Binding var avgCostPerShare: String
    
    let stock: PortfolioStock
    let holdingInfo: HoldingInfo?
    let onCommit: (PortfolioStock) -> Void
    
    var body: some View {
        VStack {
            Text("Number of Shares")
                .font(.title)
                .foregroundColor(Color("textColor"))
            DarkTextField(placeholder: (holdingInfo == nil) ? "0.0" : "\(holdingInfo!.numOfShares, specifier: "%.2f")", input: $numOfShares)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            Spacer()
                .frame(height: 20)
            
            Text("Average Cost Per Share")
                .font(.title)
                .foregroundColor(Color("textColor"))
            HStack {
                Text("$")
                    .font(.title)
                    .foregroundColor(Color("textColor"))
                DarkTextField(placeholder: (holdingInfo == nil) ? "0.0" : "\(holdingInfo!.avgCostPerShare, specifier: "%.2f")", input: $avgCostPerShare)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            Spacer()
                .frame(height: 20)
            
            CheckMarkButton(size: CGSize(width: 50, height: 50), action: update)
        }
        .padding()
        .embedInRectangle()
    }
    
    private func update() {
        if !(self.numOfShares.isEmpty && self.avgCostPerShare.isEmpty) {
            UIApplication.shared.endEditing(true)
            self.editMode = .inactive
            self.onCommit(self.stock)
        }
    }
}
