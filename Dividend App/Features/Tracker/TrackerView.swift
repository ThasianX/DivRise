//
//  TrackerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct TrackerView: View {
    let monthlyRecords: [Record]
    let monthlyDividends: [Double]
    
    var body: some View {
        // TODO: Add a toggle between bar chart and line chart. Landscape mode
        VStack {
            if monthlyRecords.count == 0 {
                Text("Add dividends to display graph")
            } else {
                BarChartView(data: monthlyDividends, title: "Dividends", style: Styles.barChartStyleOrangeLight)
            }
//                LineView(records: monthlyRecords, data: monthlyDividends, title: "Monthly Dividends", style: Styles.lineChartStyleOne)
//                .padding()
        }
    }
    
}

struct TrackerView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerView(monthlyRecords: [Record(month: "Jan", day: nil, year: "2019"), Record(month: "Jan", day: nil, year: "2019"), Record(month: "Jan", day: nil, year: "2019")], monthlyDividends: [8, 23, 28])
//        TrackerView(monthlyRecords: [Record(month: "Jan", year: "2019")], monthlyDividends: [8])
    }
}
