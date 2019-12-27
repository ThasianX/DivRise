//
//  TrackerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct TrackerView: View {
    let monthlyRecords: [Record]
    let monthlyDividends: [Double]
    
    var body: some View {
        Text("Line graph of dividends go here")
    }
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(monthlyRecords: [], monthlyDividends: [])
    }
}
