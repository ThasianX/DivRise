//
//  ScheduleListRow.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

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
                    .foregroundColor(Color.green)
                
                Text(date.mediumStyle)
                    .font(.system(size: 15))
                    .foregroundColor(Color("textColor"))
            }
        }
    }
}
