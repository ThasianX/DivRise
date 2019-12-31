//
//  View+Alert.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

extension View {
    
    func addTextFieldAlert(isShowing: Binding<Bool>,
                  stock: SearchStock?,
                  input: Binding<String>,
                  onAdd: @escaping () -> Void) -> some View {
        AddAlertView(isShowing: isShowing,
                     input: input,
                     presenting: self,
                     stock: stock,
                     onAdd: onAdd)
    }
    
}
