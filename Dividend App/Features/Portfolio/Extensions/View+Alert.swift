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
    
    // Credits: https://vmanot.com/reimplementing-swiftui-s-deprecated-relative-view-sizing-functions
    
    func relativeHeight(
        _ ratio: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        GeometryReader { geometry in
            self.frame(
                height: geometry.size.height * ratio,
                alignment: alignment
            )
        }
    }
    
    func relativeWidth(
        _ ratio: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        GeometryReader { geometry in
            self.frame(
                width: geometry.size.width * ratio,
                alignment: alignment
            )
        }
    }
    
    func relativeSize(
        width widthRatio: CGFloat,
        height heightRatio: CGFloat,
        alignment: Alignment = .center
    ) -> some View {
        GeometryReader { geometry in
            self.frame(
                width: geometry.size.width * widthRatio,
                height: geometry.size.height * heightRatio,
                alignment: alignment
            )
        }
    }
    
}
