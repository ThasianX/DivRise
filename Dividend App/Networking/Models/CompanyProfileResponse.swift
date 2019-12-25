//
//  PortfolioStockResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import Foundation

// MARK: - PortfolioStock
struct CompanyProfileResponse: Codable {
    let symbol: String
    let profile: Profile
}

// MARK: - Profile
struct Profile: Codable {
    let price: Double
    let beta, mktCap, lastDiv: String
    let changesPercentage, companyName, exchange, industry: String
    let website: String
    let profileDescription, ceo, sector: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case price, beta, mktCap, lastDiv, changesPercentage, companyName, exchange, industry, website
        case profileDescription = "description"
        case ceo, sector, image
    }
}

extension CompanyProfileResponse {
    static let noResponse = CompanyProfileResponse(
        symbol: "",
        profile: Profile(price: 0.0, beta: "", mktCap: "", lastDiv: "", changesPercentage: "", companyName: "", exchange: "", industry: "", website: "", profileDescription: "", ceo: "", sector: "", image: "")
    )
}
