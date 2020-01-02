//
//  StockNewsView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/1/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct StockNewsView: View {
    let stockNews: [StockNews]
    
    var body: some View {
        VStack {
            Text("From NewsApi")
        }
    }
}

struct StockNewsView_Previews: PreviewProvider {
    static var previews: some View {
        StockNewsView(stockNews: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock])
    }
}
