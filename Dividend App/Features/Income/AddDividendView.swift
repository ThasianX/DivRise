//
//  AddDividendView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/30/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct AddDividendView: View {
    @Binding var input: String
    let onAdd: () -> Void
    
    var body: some View {
        ZStack {
            Color("modalBackground")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text(Date().getPreviousMonth()!.mediumStyleNoDay)
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .multilineTextAlignment(.center)
                CustomDivider()
                HStack {
                    Text("$")
                        .font(.system(size: 50))
                        .bold()
                        .foregroundColor(Color("textColor"))
                    DarkTextField(placeholder: "0.00", input: $input)
                        .font(.system(size: 50))
                        .keyboardType(.decimalPad)
                    Spacer()
                }
                Button(action: onAdd) {
                    Image(systemName: "dollarsign.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("update"))
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct AddDividendView_Previews: PreviewProvider {
    static var previews: some View {
        AddDividendView(input: .constant(""), onAdd: { })
            .colorScheme(.light)
    }
}
