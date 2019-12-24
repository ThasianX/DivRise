//
//  View+Embed.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

// Credits: https://github.com/mecid/swiftui-recipes-app/blob/master/Recipes/Shared/Extensions/View.swift

import SwiftUI

extension View {
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
}
