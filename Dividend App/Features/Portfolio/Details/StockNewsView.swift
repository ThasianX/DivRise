//
//  StockNewsView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/1/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI
import URLImage

struct StockNewsView: View {
    let stockNews: [StockNews]
    
    var body: some View {
        let newsCount = stockNews.count
        
        return ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Powered by NewsAPI")
                    .foregroundColor(.gray)
                
                if newsCount >= 5 {
                    ForEach(0..<5, id: \.self) { i in
                        BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                    }
                    
                    if newsCount >= 6 {
                        BigNewsRow(entry: self.stockNews[5])
                        
                        if newsCount >= 8 {
                            HStack {
                                BasicNewsRow(entry: self.stockNews[6], orientation: "vertical")
                                Spacer()
                                BasicNewsRow(entry: self.stockNews[7], orientation: "vertical")
                            }
                            
                            if newsCount >= 10 {
                                BasicNewsRow(entry: self.stockNews[8], orientation: "horizontal")
                                BasicNewsRow(entry: self.stockNews[9], orientation: "horizontal")
                                
                                if newsCount >= 11 {
                                    BigNewsRow(entry: self.stockNews[10])
                                    
                                    ForEach(11..<newsCount, id: \.self) { i in
                                        BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                    }
                                } else {
                                    ForEach(10..<newsCount, id: \.self) { i in
                                        BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                    }
                                }
                            } else {
                                ForEach(8..<newsCount, id: \.self) { i in
                                    BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                }
                            }
                        } else {
                            ForEach(6..<newsCount, id: \.self) { i in
                                BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                            }
                        }
                    } else {
                        ForEach(5..<newsCount, id: \.self) { i in
                            BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                        }
                    }
                } else {
                    ForEach(0..<newsCount, id: \.self) { i in
                        BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                    }
                }
            }
        }
        .padding()
    }
}

struct StockNewsView_Previews: PreviewProvider {
    static var previews: some View {
        StockNewsView(stockNews: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock]).previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
    }
}

struct BasicNewsRow: View {
    let entry: StockNews
    let orientation: String
    
    var body: some View {
        ZStack {
            if orientation == "vertical" {
                VStack(alignment: .leading) {
                    URLImage(self.entry.image) { proxy in
                        proxy.image
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                    .frame(width: UIScreen.main.bounds.width*0.43, height: UIScreen.main.bounds.width*0.3)
                    .cornerRadius(8)
                    
                    Text(self.entry.source)
                        .font(.headline)
                    Text(self.entry.title)
                        .bold()
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                        .frame(height: 5)
                    Text(self.entry.publishedSince)
                        .font(.caption)
                }
                .frame(width: UIScreen.main.bounds.width*0.43)
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.entry.source)
                            .font(.headline)
                        Text(self.entry.title)
                            .bold()
                            .font(.system(size: 18))
                        Spacer()
                        Text(self.entry.publishedSince)
                            .font(.caption)
                    }
                    .frame(height: UIScreen.main.bounds.width*0.35)
                    
                    Spacer()
                    
                    URLImage(self.entry.image) { proxy in
                        proxy.image
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                    .frame(width: UIScreen.main.bounds.width*0.35, height: UIScreen.main.bounds.width*0.35)
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct BigNewsRow: View {
    let entry: StockNews
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(self.entry.image) { proxy in
                proxy.image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.7)
            .cornerRadius(8)
            
            Text(self.entry.source)
                .font(.headline)
            Text(self.entry.title)
                .bold()
                .font(.system(size: 25))
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
                .frame(height: 5)
            Text(self.entry.publishedSince)
                .font(.caption)
        }
    }
}
