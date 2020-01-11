//
//  SectorAttributes.swift
//  Dividend App
//
//  Created by Kevin Li on 1/8/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation
import SwiftUI

struct SectorAttributes {
    static let technology = "Technology"
    static let communicationServices = "Communication Services"
    static let industrials = "Industrials"
    static let healthcare = "Healthcare"
    static let energy = "Energy"
    static let consumerDefensive = "Consumer Defensive"
    static let consumerCyclical = "Consumer Cyclical"
    static let basicMaterials = "Basic Materials"
    static let financialServices = "Financial Services"
    static let realEstate = "Real Estate"
    static let utilities = "Utilities"
    
    static let images = [
        technology: "technology",
        communicationServices: "communication",
        industrials: "industrials",
        healthcare: "healthcare",
        energy: "energy",
        consumerDefensive: "consumerDefensive",
        consumerCyclical: "consumerCyclical",
        basicMaterials: "basicMaterials",
        financialServices: "financialServices",
        realEstate: "realEstate",
        utilities: "utilities"
    ]
    
    static let sectorOrder: [String] = [technology, communicationServices, industrials, healthcare, energy, consumerDefensive, consumerCyclical, basicMaterials, financialServices, realEstate, utilities]
    
    static let sectorColor = [
        technology: UIColor.blue,
        communicationServices: UIColor.green,
        industrials: UIColor.gray,
        healthcare: UIColor.magenta,
        energy: UIColor.yellow,
        consumerDefensive: UIColor.red,
        consumerCyclical: UIColor.orange,
        basicMaterials: UIColor.purple,
        financialServices: UIColor.systemTeal,
        realEstate: UIColor.systemIndigo,
        utilities: UIColor.cyan
    ]
    
    static let defaultSectors: [String: [PortfolioStock]] = [technology: [], communicationServices: [], industrials: [], healthcare: [], energy: [], consumerDefensive: [], consumerCyclical: [], basicMaterials: [], financialServices: [], realEstate: [], utilities: []]
}
