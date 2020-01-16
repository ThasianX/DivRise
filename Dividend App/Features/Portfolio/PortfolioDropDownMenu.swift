//
//  DropDownMenu.swift
//  Dividend App
//
//  Created by Kevin Li on 1/15/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioDropDownMenu: View {
    @State private var expanded = false
    
    var body: some View {
        VStack {
            HStack {
                Text("  ")
            }
        }
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioDropDownMenu()
    }
}
