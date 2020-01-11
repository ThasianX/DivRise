//
//  SwiftUIView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct AddAlertView<Presenting>: View where Presenting: View  {
    @SwiftUI.Environment(\.colorScheme) var colorScheme
    @Binding var isShowing: Bool
    @Binding var input: String
    
    let presenting: Presenting
    let stock: SearchStock?
    let onAdd: () -> Void
    
    var body: some View {
        ZStack {
            presenting
                .disabled(isShowing)
            
            if isShowing {
                VStack {
                    Text(stock!.ticker)
                        .font(.title)
                        .foregroundColor(Color("textColor"))
                    
                    Text("Enter your starting annual dividend amount")
                    .fixedSize(horizontal: false, vertical: true)
                        .font(.headline)
                        .foregroundColor(Color("textColor"))
                    
                    HStack {
                        if !input.isEmpty {
                            Text("$")
                                .font(.system(size: 25))
                                .foregroundColor(Color("textColor"))
                        }
                        
                        if colorScheme == ColorScheme.dark {
                            TextField("Current: $\(Double(stock!.dividend)!, specifier: "%.2f")", text: $input)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 25))
                            .foregroundColor(Color("textColor"))
                        } else {
                          TextField("Current: $\(Double(stock!.dividend)!, specifier: "%.2f")", text: $input)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 25))
                            .colorInvert()
                        }
                    }
                    Divider()
                    HStack {
                        Button(action: {
                            UIApplication.shared.endEditing(true)
                            self.reset()
                        }) {
                            Spacer()
                            Text("Cancel")
                                .foregroundColor(.orange)
                            Spacer()
                        }
                        Divider()
                        Button(action: {
                            UIApplication.shared.endEditing(true)
                            self.onAdd()
                            self.reset()
                            
                        }) {
                            Spacer()
                            Text("Add")
                            .foregroundColor(.orange)
                            Spacer()
                        }
                    }
                    .frame(height: 30)
                }
                .padding()
                .background(Color.black)
                .cornerRadius(16)
                .relativeHeight(0.35)
                .relativeWidth(0.7)
            }
        }
    }
    
    private func reset() {
        self.isShowing.toggle()
        self.input = ""
    }
}
