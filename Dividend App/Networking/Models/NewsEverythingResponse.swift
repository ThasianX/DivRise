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
    let totalResults: Int
    let articles: [Article]
    
    // MARK: - Article
    struct Article: Codable, Hashable {
        let source: Source
        let author, title, articleDescription: String
        let url: String
        let urlToImage: String
        let publishedAt: Date
        let content: String

        enum CodingKeys: String, CodingKey {
            case source, author, title
            case articleDescription = "description"
            case url, urlToImage, publishedAt, content
        }
    }

    // MARK: - Source
    struct Source: Codable, Hashable {
        let name: String
    }
}

extension NewsEverythingResponse {
    static let noResponse = NewsEverythingResponse(status: "", totalResults: 0, articles: [])
}


