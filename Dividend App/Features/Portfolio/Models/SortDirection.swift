//
//  SortDirection.swift
//  Dividend App
//
//  Created by Kevin Li on 1/16/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

struct SortDirection: Codable, Hashable {
    static let up = "↑"
    static let down = "↓"
    
    static func toggle(direction: String) -> String {
        return (direction == up) ? down : up
    }
    
    static func comparator<T: Comparable>(sort: String, direction: String, left: T, right: T) -> Bool {
        switch sort {
        case PortfolioSortState.symbol, PortfolioSortState.name:
            return (direction == down) ? left < right : left > right
        case PortfolioSortState.startingDiv, PortfolioSortState.currentDiv, PortfolioSortState.growth:
            return (direction == down) ? left > right : left < right
        default:
            fatalError("Sort state should be valid")
        }
    }
    
    static func sortString(sort: String, direction: String) -> String {
        let string: String
        switch sort {
        case PortfolioSortState.symbol, PortfolioSortState.name:
            string = "\(sort) \((direction == up) ? "z-a" : "a-z")"
        case PortfolioSortState.startingDiv, PortfolioSortState.currentDiv, PortfolioSortState.growth:
            string = "\(sort) \((direction == up) ? "low to high" : "high to low")"
        default:
            fatalError("Sort state should be valid")
        }
        return string
    }
}
