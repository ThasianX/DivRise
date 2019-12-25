//
//  SideEffect.swift
//  Dividend App
//
//  Created by Kevin Li on 12/24/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Combine

func search(query: String) -> AnyPublisher<AppAction, Never> {
    Current.request.getSearchedStocks(query: query)
        .map {
            Logger.info("\($0)")
            return .setSearchResults(results: $0)
            
    }
        .eraseToAnyPublisher()
}
