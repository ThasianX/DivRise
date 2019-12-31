//
//  DetailState.swift
//  Dividend App
//
//  Created by Kevin Li on 12/29/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

class DetailState: ObservableObject {
    @Published var selectedPeriod = "annual"
    @Published var attributeOrder = ["peRatios", "pegRatios", "payoutRatios", "dividendYields", "dividendPerShares", "fcfes", "netDebtToEBITDAs", "grahamNumbers", "debtToEquitys", "operatingProfitMargins", "assetTurnoverRatios", "debtToCapitalRatios"]
}
