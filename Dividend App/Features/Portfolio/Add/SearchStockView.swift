//
//  SearchStockView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

// Credits: https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui?rq=1

import SwiftUI

struct SearchStockView: View {
    @Binding var query: String
    @Binding var showCancelButton: Bool
    @Binding var showingAlert: Bool
    @Binding var selectedStock: SearchStock?
    
    let searchedStocks: [SearchStock]
    let onCommit: () -> Void
    
    var body: some View {
        ZStack {
            Color("modalBackground")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 8)
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search stocks, funds...", text: $query, onCommit: onCommit)
                            .foregroundColor(Color.black)
                        
                        Button(action: {
                            self.query = ""
                            self.onCommit()
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(query == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(Color.gray)
                    .background(Color.white)
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.query = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                
                List(searchedStocks, id: \.self) { stock in
                    Button(action: {
                        if stock.dividend != "" {
                            self.selectedStock = stock
                            self.showingAlert = true
                        }
                    }) {
                        SearchStockRow(stock: stock)
                    }
                }
                .transition(.identity)
                .animation(nil)
                .resignKeyboardOnDragGesture()
            }
        }
        
    }
}

struct SearchStockView_Previews: PreviewProvider {
    static var previews: some View {
        SearchStockView(query: .constant(""), showCancelButton: .constant(false), showingAlert: .constant(false), selectedStock: .constant(nil), searchedStocks: [.mock, .mock, .mock, .mock], onCommit: { })
    }
}
