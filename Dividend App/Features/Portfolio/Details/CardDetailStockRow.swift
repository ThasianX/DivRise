//
//  DetailStockRow.swift
//  Dividend App
//
//  Created by Kevin Li on 12/29/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct CardDetailStockRow: View {
    let abbreviatedNames: [String]
    let fullNames: [String]
    let records: [Record]
    let attributeValues: [[Double]]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<abbreviatedNames.count) { index in
                    GeometryReader { geometry in
                        CardView(
                            abbreviatedName: self.abbreviatedNames[index],
                            fullName: self.fullNames[index],
                            description: "",
                            records: self.records,
                            values: self.attributeValues[index])
                            .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -20), axis: (x: 0, y: 10.0, z: 0))
                            .onTapGesture {
                                
                        }
                    }
                    .frame(width: 250, height: 150)
                }
            }
            .padding(40)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: 460)
    }
}

//struct DetailStockRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStockRow()
//    }
//}
