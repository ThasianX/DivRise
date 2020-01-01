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
        VStack(alignment: .leading, spacing: 30) {
            Text(Date().mediumStyleNoDay)
                .font(.system(size: 60))
                .bold()
            
            Divider()
            HStack {
                Text("$")
                    .font(.system(size: 50))
                    .bold()
                TextField("0.00", text: $input)
                    .font(.system(size: 50))
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Spacer()
                Button(action: onAdd) {
                    Image(systemName: "signature")
                    .resizable()
                        .frame(width: 50, height: 50)
                }
                Spacer()
            }
        }
        .padding(40)
    }
}

struct AddDividendView_Previews: PreviewProvider {
    static var previews: some View {
        AddDividendView(input: .constant(""), onAdd: { })
    }
}
