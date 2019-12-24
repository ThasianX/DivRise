//
//  PortfolioDetailContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioDetailContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    let ticker: String
    
    var body: some View {
        PortfolioDetailView()
    }
}
