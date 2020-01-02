//
//  StockNews.swift
//  Dividend App
//
//  Created by Kevin Li on 1/1/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import Foundation

struct StockNews: Codable, Hashable {
    let title: String
    let source: String
    let image: URL
    let url: URL
    let publishedSince: String
}
