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
    let title: Text
    let onAdd: (_ stock: SearchStock) -> Void
    
    var body: some View {
        ZStack {
            presenting
                .disabled(isShowing)
            VStack {
                title
                TextField("", text: $input)
                Divider()
                HStack {
                    Button(action: {
                        withAnimation {
                            self.isShowing.toggle()
                        }
                    }) {
                        Text("Dismiss")
                    }
                }
            }
            .padding()
            .background(Color.white)
        }
    }
}
