//
//  Cardview.swift
//  Dividend App
//
//  Created by Kevin Li on 12/30/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @State var expanded = false
    let abbreviatedName: String
    let fullName: String
    let description: String
    let records: [Record]
    let values: [Double]

    var body: some View {
        ZStack {
            if expanded {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.black)
                    .animation(.easeInOut)
            }

            
            VStack {
                if expanded {
                    Text(fullName)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                LineChartView(records: records, data: values, title: abbreviatedName)
            }
            .animation(.easeInOut)
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 250, height: expanded ? 400 : 300)
        .onTapGesture {
            self.expanded.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(abbreviatedName: "P/E", fullName: "Price-to-Earnings Ratio", description: "Helps investors by gauging how long it would take for you to earn your money back", records: [.mock, .mock, .mock, .mock, .mock, .mock], values: [50, 60, 80, 200, 300, 350])
    }
}
