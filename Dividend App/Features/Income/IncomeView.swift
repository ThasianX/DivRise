//
//  TrackerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct IncomeView: View {
    let monthlyRecords: [Record]
    let monthlyDividends: [Double]
    
    var body: some View {
        ZStack {
            Color("modalBackground")
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                if self.monthlyRecords.count == 0 {
                    ZStack {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                BarChartView(records: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock], data: [8,23,54,32,12,37,7,23,43], title: "Passive Income", style: Styles.barChartStyleOrangeDark, form: CGSize(width: geometry.size.width*0.95, height: geometry.size.height*0.95))
                                    .allowsHitTesting(false)
                                    .opacity(0.3)
                                
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Not enough data to display")
                                    .foregroundColor(Color("textColor"))
                                    .font(.headline)
                                    .italic()
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            BarChartView(records: self.monthlyRecords, data: self.monthlyDividends, title: "Passive Income", style: Styles.barChartStyleOrangeDark, form: CGSize(width: geometry.size.width*0.95, height: geometry.size.height*0.95))
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView(monthlyRecords: [Record(month: "Jan", day: nil, year: "2019"), Record(month: "Jan", day: nil, year: "2019"), Record(month: "Jan", day: nil, year: "2019")], monthlyDividends: [8, 23, 28])
    }
}
