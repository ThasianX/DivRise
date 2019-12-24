//
//  View+Alert.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

extension View {

    func addAlert(isShowing: Binding<Bool>,
                        title: Text,
                        input: Binding<String>,
                        addStock: @escaping (_ stock: SearchStock) -> Void) -> some View {
        AddAlertView(isShowing: isShowing,
                     input: input,
                       presenting: self,
                       title: title,
                       onAdd: addStock)
    }

}
