//
//  PortfolioStock.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

struct PortfolioStock: Codable, Hashable {
    let ticker: String
    let fullName: String
    let image: String
    let startingDividend: Double
    let currentDividend: Double
    let growth: Double
    let sector: String
    let frequency: String
}

extension PortfolioStock {
    static let mock = PortfolioStock(ticker: "AAPL", fullName: "Apple Inc", image: "https://financialmodelingprep.com/images-New-jpg/AAPL.jpg", startingDividend: 0.55, currentDividend: 0.77, growth: 0.77 / 0.55, sector: "Technology", frequency: "Quarterly")
    
    static let sample = [
        PortfolioStock(ticker: "AAPL", fullName: "Apple Inc.", image: "https://financialmodelingprep.com/images-New-jpg/AAPL.jpg", startingDividend: 0.55, currentDividend: 2.92, growth: 2.92 / 0.55, sector: "Technology", frequency: "Quarterly"),
        PortfolioStock(ticker: "T", fullName: "AT&T Inc.", image: "https://financialmodelingprep.com/images-New-jpg/T.jpg", startingDividend: 0.9, currentDividend: 2.04, growth: 2.04 / 0.9, sector: "Communication Services", frequency: "Quarterly"),
        PortfolioStock(ticker: "AVGO", fullName: "Broadcom Limited", image: "https://financialmodelingprep.com/images-New-jpg/AVGO.jpg", startingDividend: 8, currentDividend: 10.6, growth: 10.6 / 8, sector: "Technology", frequency: "Quarterly"),
        PortfolioStock(ticker: "MMM", fullName: "3M Company", image: "https://financialmodelingprep.com/images-New-jpg/MMM.jpg", startingDividend: 5, currentDividend: 5.76, growth: 5.76 / 5, sector: "Industrials", frequency: "Quarterly"),
        PortfolioStock(ticker: "ABBV", fullName: "AbbVie Inc.", image: "https://financialmodelingprep.com/images-New-jpg/ABBV.jpg", startingDividend: 4, currentDividend: 4.28, growth: 4.28 / 4, sector: "Healthcare", frequency: "Quarterly"),
        PortfolioStock(ticker: "ABT", fullName: "Abbott Laboratories", image: "https://financialmodelingprep.com/images-New-jpg/ABT.jpg", startingDividend: 1, currentDividend: 1.28, growth: 1.28 / 1, sector: "Healthcare", frequency: "Quarterly"),
        PortfolioStock(ticker: "CVX", fullName: "Chevron Corporation", image: "https://financialmodelingprep.com/images-New-jpg/CVX.jpg", startingDividend: 3.7, currentDividend: 4.76, growth: 4.76 / 3.7, sector: "Energy", frequency: "Quarterly"),
        PortfolioStock(ticker: "KO", fullName: "Coca-Cola Company (The)", image: "https://financialmodelingprep.com/images-New-jpg/KO.jpg", startingDividend: 1.5, currentDividend: 1.6, growth: 1.6 / 1.5, sector: "Consumer Defensive", frequency: "Quarterly"),
        PortfolioStock(ticker: "CLX", fullName: "Clorox Company (The)", image: "https://financialmodelingprep.com/images-New-jpg/CLX.jpg", startingDividend: 3.2, currentDividend: 3.84, growth: 3.84 / 3.2, sector: "Consumer Defensive", frequency: "Quarterly"),
        PortfolioStock(ticker: "WMT", fullName: "Walmart Inc.", image: "https://financialmodelingprep.com/images-New-jpg/WMT.jpg", startingDividend: 1.7, currentDividend: 2.12, growth: 2.12 / 1.7, sector: "Consumer Defensive", frequency: "Quarterly"),
        PortfolioStock(ticker: "WBA", fullName: "Walgreens Boots Alliance Inc.", image: "https://financialmodelingprep.com/images-New-jpg/WBA.jpg", startingDividend: 1.7, currentDividend: 1.76, growth: 1.76 / 1.7, sector: "Healthcare", frequency: "Quarterly"),
        PortfolioStock(ticker: "MCD", fullName: "McDonald's Corporation", image: "https://financialmodelingprep.com/images-New-jpg/MCD.jpg", startingDividend: 3, currentDividend: 4.64, growth: 4.64 / 3, sector: "Consumer Cyclical", frequency: "Quarterly"),
        PortfolioStock(ticker: "JNJ", fullName: "Johnson & Johnson", image: "https://financialmodelingprep.com/images-New-jpg/JNJ.jpg", startingDividend: 3.32, currentDividend: 3.6, growth: 3.6 / 3.32, sector: "Healthcare", frequency: "Quarterly"),
        PortfolioStock(ticker: "LOW", fullName: "Lowe's Companies Inc.", image: "https://financialmodelingprep.com/images-New-jpg/LOW.jpg", startingDividend: 1.56, currentDividend: 1.92, growth: 1.92 / 1.56, sector: "Consumer Cyclical", frequency: "Quarterly"),
        PortfolioStock(ticker: "SYY", fullName: "Sysco Corporation", image: "https://financialmodelingprep.com/images-New-jpg/SYY.jpg", startingDividend: 1.24, currentDividend: 1.56, growth: 1.56 / 1.24, sector: "Consumer Defensive", frequency: "Quarterly")
    ]
}
