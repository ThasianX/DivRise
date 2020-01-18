//
//  DetailAttributeOrdering.swift
//  Dividend App
//
//  Created by Kevin Li on 1/17/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct DetailAttributeOrdering: View {
    @Binding var showDetailOrdering: Bool
    @Binding var attributeOrder: [String]
    
    let fullAttributeNames: [String]
    
    var body: some View {
        List {
            ForEach(fullAttributeNames, id: \.self) { attribute in
                Text(attribute)
                    .foregroundColor(Color("textColor"))
            }
            .onMove(perform: onMove)
        }
        .colorScheme(.dark)
        .background(Color("modalBackground").edgesIgnoringSafeArea(.all))
    }
    
    private func onMove(from source: IndexSet, to destination: Int) {
        attributeOrder.move(fromOffsets: source, toOffset: destination)
    }
}
