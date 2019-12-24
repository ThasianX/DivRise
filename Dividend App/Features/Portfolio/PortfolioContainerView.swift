//
//  PortfolioContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        Text("Portfolio")
    }
}

