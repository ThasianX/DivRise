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
                        .font(.headline)
                    
                    Text("Enter your starting annual dividend amount")
                        .font(.caption)
                    
                    HStack {
                        if !input.isEmpty {
                            Text("$")
                        }
                        
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
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        Divider()
                        Button(action: {
                            withAnimation {
                                self.onAdd()
                                self.reset()
                            }
                        }) {
                            Spacer()
                            Text("Add")
                            Spacer()
                        }
                    }
                }
                .colorInvert()
                .padding()
                .background(Color.backgroundColor(for: colorScheme))
                .cornerRadius(16)
                .relativeHeight(0.2)
                .relativeWidth(0.7)
            }
            
        }
    }
    
    private func reset() {
        self.isShowing.toggle()
        self.input = ""
    }
}
