//
//  NewsEverythingResponse.swift
//  Dividend App
//
//  Created by Kevin Li on 1/1/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

// MARK: - Pokedex
struct NewsEverythingResponse: Codable, Hashable {
    let status: String
    let articles: [Article]
    
    // MARK: - Article
    struct Article: Codable, Hashable {
        let source: Source
        let title: String
        let url: String
        let urlToImage: String
        let publishedAt: String

        enum CodingKeys: String, CodingKey {
            case source, title
            case url, urlToImage, publishedAt
        }
    }

    // MARK: - Source
    struct Source: Codable, Hashable {
        let name: String
    }
}

extension NewsEverythingResponse {
    static let noResponse = NewsEverythingResponse(status: "", articles: [])
}


