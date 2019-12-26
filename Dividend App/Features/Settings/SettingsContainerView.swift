//
//  SettingsContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/26/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct SettingsContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    var body: some View {
        Text("Settings")
    }
}

struct SettingsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContainerView()
    }
}
