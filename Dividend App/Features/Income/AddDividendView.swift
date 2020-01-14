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
            Color("onClickBackground")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 30) {
                Text(Date().getPreviousMonth()!.mediumStyleNoDay)
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color("textColor"))
                Divider()
                
                HStack {
                    Text("$")
                        .font(.system(size: 50))
                        .bold()
                        .foregroundColor(Color("textColor"))
                    TextField("0.00", text: $input)
                        .font(.system(size: 50))
                        .foregroundColor(Color("textColor"))
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Spacer()
                    Button(action: onAdd) {
                        Image(systemName: "dollarsign.circle.fill")
                        .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("update"))
                    }
                    Spacer()
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
