//
//  SwiftUIView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct AddAlertView<Presenting>: View where Presenting: View  {
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
                        .font(.headline)
                        .padding(.bottom)
                    
                    Text("Enter your starting annual dividend amount")
                        .font(.caption)
                    
                    HStack {
                        TextField("Starting dividend...", text: $input)
                            .keyboardType(.decimalPad)
                        
                        Button(action: {
                            self.input = self.stock!.dividend
                        }) {
                            Text("Current")
                        }
                    }
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.reset()
                            }
                        }) {
                            Text("Cancel")
                        }
                        Button(action: {
                            withAnimation {
                                self.onAdd()
                                self.reset()
                            }
                        }) {
                            Text("Add")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .relativeHeight(0.7)
                .relativeWidth(0.7)
            }
            
        }
    }
    
    private func reset() {
        self.isShowing.toggle()
        self.input = ""
    }
}
