//
//  KeyboardResponsiveModifier.swift
//  Dividend App
//
//  Created by Kevin Li on 1/18/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

// Credits: https://stackoverflow.com/a/59514820/6074750

import SwiftUI

struct KeyboardResponsiveModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    let bottomOffset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                    self.offset = height - (bottomOffset ?? 0)
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    self.offset = 0
                }
        }
    }
}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
        modifier(KeyboardResponsiveModifier())
    }
}
