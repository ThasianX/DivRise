//
//  SwiftUIView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct AddAlertView<Presenting>: View where Presenting: View  {
    @SwiftUI.Environment(\.colorScheme) var colorScheme: ColorScheme
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
                    
                    Text("Enter your starting annual dividend amount")
                        .font(.headline)
                    
                    HStack {
                        if !input.isEmpty {
                            Text("$")
                                .font(.system(size: 25))
                        }
                        
                        TextField("Current: $\(Double(stock!.dividend)!, specifier: "%.2f")", text: $input)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 25))
                    }
                    Divider()
                    HStack {
                        Button(action: {
                            self.reset()
                            
                        }) {
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        Divider()
                        Button(action: {
                            self.onAdd()
                            self.reset()
                            
                        }) {
                            Spacer()
                            Text("Add")
                            Spacer()
                        }
                    }
                    .frame(height: 30)
                }
                .colorInvert()
                .padding()
                .background(Color.backgroundColor(for: colorScheme))
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
