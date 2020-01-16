//
//  ScheduleView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/15/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    let upcomingSchedule: [(id: String, stock: PortfolioStock, date: Date, amount: String)]
    let yearlyDividendIncome: Double
    
    var body: some View {
        ZStack {
            Color("modalBackground").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Annual income: $\(yearlyDividendIncome, specifier: "%.2f")")
                    .foregroundColor(Color("textColor"))
                    .padding(.leading, 20)
                    .font(.headline)
                List(upcomingSchedule, id: \.id) { tuple in
                        ScheduleListRow(stock: tuple.1, date: tuple.2, amount: tuple.3)
                    }
            }
        }
    }
}

struct ScheduleListRow: View {
    let stock: PortfolioStock
    let date: Date
    let amount: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("textColor"))
                
                Text(stock.fullName)
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(amount)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("textColor"))
                
                Text(date.mediumStyle)
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
            }
        }
    }
}
