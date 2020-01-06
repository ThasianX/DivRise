//
//  EditInfoView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/4/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct EditInfoView: View {
    @State private var startingDividend: String = ""
    @Binding var showEditInfo: Bool
    
    let portfolioStock: PortfolioStock
    let selectedIndex: Int
    let onUpdate: (Int, Double) -> Void
    
    var body: some View {
        ZStack {
            Color("modalBackground")
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                VStack(alignment: .leading, spacing: 20.0) {
                    HStack {
                        if portfolioStock.image != "" {
                            URLImage(URL(string: portfolioStock.image)!) { proxy in
                                proxy.image
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipped()
                            }
                            .cornerRadius(8)
                            .frame(width: 50, height: 50)
                        }
                        
                        Text(portfolioStock.ticker)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("textColor"))
                    }
                    
                    Text(portfolioStock.fullName)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("textColor"))
                    
                    Text("Edit starting dividend")
                        .foregroundColor(Color("textColor"))
                    
                    HStack {
                        Text("$")
                            .font(.system(size: 30))
                            .foregroundColor(Color("textColor"))
                        TextField("\(portfolioStock.startingDividend, specifier: "%.2f")", text: $startingDividend)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 30))
                            .foregroundColor(Color("textColor"))
                            .frame(width: 100)
                        Spacer()
                    }
                    
                    Button(action: {
                        if let dividend = Double(self.startingDividend), dividend > 0 {
                            self.onUpdate(self.selectedIndex, dividend)
                            self.showEditInfo = false
                        }
                    }) {
                        Text("Update")
                            .font(.headline)
                            .foregroundColor(Color("update"))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                }
                .padding(30)
                
                VStack {
                    Button(action: {
                        self.showEditInfo = false
                    }) {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

struct EditInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditInfoView(showEditInfo: .constant(true), portfolioStock: .mock, selectedIndex: 0, onUpdate: { _, _ in })
            .colorScheme(.dark)
    }
}
