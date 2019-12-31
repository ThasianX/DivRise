//
//  CurrentDetailStockRow.swift
//  Dividend App
//
//  Created by Kevin Li on 12/29/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct CurrentDetailStockRow: View {
    let attributeNames: [String]
    let attributeValues: [[Double]]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            ForEach(attributeValues.indexed(), id: \.1.self) { i, values in
                HStack {
                    VStack {
                        ForEach(values.indexed(), id: \.1.self) { j, value in
                            HStack {
                                Text("\(self.attributeNames[i*3 + j])")
                                    .font(.caption)
                                Spacer()
                                
                                Text("\(value.shortStringRepresentation)")
                                    .font(.caption)
                                
                            }
                            .frame(width: 120)
                        }
                    }
                    Divider()
                }
            }
        }
        .padding(40)
        .frame(height: 60)
        Spacer()
    }
    }
}

struct CurrentDetailStockRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDetailStockRow(attributeNames: ["P/E", "Payout", "ND/EBITDA", "Graham", "ROIC", "Yield"], attributeValues: [[5, 50, 45.65], [5, 3]])
    }
}
