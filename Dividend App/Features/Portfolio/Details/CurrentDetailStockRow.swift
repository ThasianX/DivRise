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
                                
                                self.getProperName(name: self.attributeNames[i*3 + j], value: value)
//                                if self.attributeNames[i*3 + j] == "Payout" || self.attributeNames[i*3 + j] == "Yield" {
//                                    Text("\(value, specifier: "%.2f")%")
//                                    .font(.caption)
//                                } else if self.attributeNames[i*3 + j] == "FCFE" {
//                                    Text("$\(value, specifier: "%.2f")")
//                                    .font(.caption)
//                                } else if self.attributeNames[i*3 + j] == "DPS" {
//                                    Text("$\(value, specifier: "%.2f")")
//                                    .font(.caption)
//                                } else {
//                                    Text("\(value, specifier: "%.2f")")
//                                    .font(.caption)
//                                }
                                
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
    
    private func getProperName(name: String, value: Double) -> Text {
        if name == "Payout" || name == "Yield" || name == "OPM" {
            return Text("\(value, specifier: "%.2f")%")
            .font(.caption)
        } else if name == "FCFE" {
            return Text("$\(value.shortStringRepresentation)")
            .font(.caption)
        } else if name == "DPS" {
            return Text("$\(value, specifier: "%.2f")")
            .font(.caption)
        } else {
            return Text("\(value, specifier: "%.2f")")
            .font(.caption)
        }
    }
}

struct CurrentDetailStockRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDetailStockRow(attributeNames: ["P/E", "Payout", "ND/EBITDA", "Graham", "ROIC", "Yield"], attributeValues: [[5, 50, 45.65], [5, 3]])
    }
}
