//
//  DetailStockRow.swift
//  Dividend App
//
//  Created by Kevin Li on 12/29/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct CardDetailStockRow: View {
    @Binding var selectedAttributeIndex: Int?
    
    let abbreviatedNames: [String]
    let fullNames: [String]
    let descriptions: [String]
    let records: [Record]
    let sharePriceRecords: [Record]
    let attributeValues: [[Double]]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<abbreviatedNames.count) { index in
                    GeometryReader { geometry in
                        CardView(
                            index: .constant(nil),
                            abbreviatedName: self.abbreviatedNames[index],
                            fullName: self.fullNames[index],
                            description: self.descriptions[index],
                            records: self.records.reversed(),
                            sharePriceRecords: self.sharePriceRecords.reversed(),
                            values: self.attributeValues[index].reversed())
                            .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - 40) / -20), axis: (x: 0, y: 10.0, z: 0))
                            .onTapGesture {
                                self.selectedAttributeIndex = index
                        }
                    }
                    .frame(width: 200, height: 250)
                }
            }
            .padding(40)
        }
        .frame(width: UIScreen.main.bounds.width, height: 300)
    }
}

//struct DetailStockRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailStockRow()
//    }
//}
