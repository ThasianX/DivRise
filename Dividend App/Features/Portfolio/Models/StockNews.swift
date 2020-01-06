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

extension StockNews {
    static let mock = StockNews(title: "5 Stocks Analysts Recommend Heading Into 2020", source: "Benzinga", image: URL(string: "https://cdn2.benzinga.com/files/imagecache/1024x768xUP/images/story/2012/chart-1905225_1280_5.jpg")!, url: URL(string: "https://www.benzinga.com/trading-ideas/long-ideas/20/01/15041911/5-stocks-analysts-recommend-heading-into-2020")!, publishedSince: "3d ago")
}
