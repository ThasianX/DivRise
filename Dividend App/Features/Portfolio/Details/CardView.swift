//
//  Cardview.swift
//  Dividend App
//
//  Created by Kevin Li on 12/30/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Binding var index: Int?
    let abbreviatedName: String
    let fullName: String
    let description: String
    let records: [Record]
    let sharePriceRecords: [Record]
    let values: [Double]

    var body: some View {
        ZStack {
            if index != nil {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.clear)
                    .animation(.easeInOut)
            }

            
            VStack(spacing: 20) {
                if index != nil {
                    Text(fullName)
                        .font(.title)
                        .foregroundColor(Color("textColor"))

                    Text(description)
                        .font(.headline)
                        .foregroundColor(Color("textColor"))
                    
                    Spacer()
                }
                
                if abbreviatedName == "Payout" || abbreviatedName == "Yield" || abbreviatedName == "OPM" {
                    LineChartView(records: records, data: values, title: abbreviatedName, detailSuffix: "%", allowGesture: (index != nil) ? true : false)
                } else if abbreviatedName == "FCFE" {
                    LineChartView(records: records, data: values, title: abbreviatedName, detailPrefix: "$", shortenDouble: true, allowGesture: (index != nil) ? true : false)
                } else if abbreviatedName == "DPS" {
                    LineChartView(records: records, data: values, title: abbreviatedName, detailPrefix: "$", allowGesture: (index != nil) ? true : false)
                } else if abbreviatedName == "Price" {
                    LineChartView(records: sharePriceRecords, data: values, title: abbreviatedName, detailPrefix: "$", allowGesture: (index != nil) ? true : false)
                } else {
                    LineChartView(records: records, data: values, title: abbreviatedName, allowGesture: (index != nil) ? true : false)
                }
                
                Spacer()
                
                if index != nil {
                    Button(action: {
                        self.index = nil
                    }) {
                        Image(systemName: "x.circle.fill")
                        .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                
            }
            .animation(.easeInOut)
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: index != nil ? 400 : 200, height: index != nil ? 600 : 250)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(index: .constant(nil), abbreviatedName: "P/E", fullName: "Price-to-Earnings Ratio", description: "Helps investors by gauging how long it would take for you to earn your money back", records: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], sharePriceRecords: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], values: [0.6137386018237082, 0.2815539332538736, 0.17518342474101156, 0.24931948665991222, -1.1515280464216635, 1.1460104011887073, 0.2818422889043964, -1.3491616766467065, 1.5056442831215968, 0.6401420838971583, -56.699696969696966])
    }
}
