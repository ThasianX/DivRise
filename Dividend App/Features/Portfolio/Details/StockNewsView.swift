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
    @Binding var showingSafari: Bool
    @Binding var url: URL
    
    let stockNews: [StockNews]
    
    var body: some View {
        let newsCount = stockNews.count
        
        return VStack(alignment: .leading, spacing: 10) {
            Text("Powered by NewsAPI")
                .foregroundColor(.gray)
            
            if newsCount >= 5 {
                ForEach(0..<5, id: \.self) { i in
                    BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                        .onTapGesture {
                            self.url = self.stockNews[i].url
                            self.showingSafari = true
                    }
                }
                
                if newsCount >= 6 {
                    BigNewsRow(entry: self.stockNews[5])
                        .onTapGesture {
                            self.url = self.stockNews[5].url
                            self.showingSafari = true
                    }
                    
                    if newsCount >= 8 {
                        HStack {
                            BasicNewsRow(entry: self.stockNews[6], orientation: "vertical")
                                .onTapGesture {
                                    self.url = self.stockNews[6].url
                                    self.showingSafari = true
                            }
                            
                            Spacer()
                            
                            BasicNewsRow(entry: self.stockNews[7], orientation: "vertical")
                                .onTapGesture {
                                    self.url = self.stockNews[7].url
                                    self.showingSafari = true
                            }
                        }
                        
                        if newsCount >= 10 {
                            BasicNewsRow(entry: self.stockNews[8], orientation: "horizontal")
                                .onTapGesture {
                                    self.url = self.stockNews[8].url
                                    self.showingSafari = true
                            }
                            
                            BasicNewsRow(entry: self.stockNews[9], orientation: "horizontal")
                                .onTapGesture {
                                    self.url = self.stockNews[9].url
                                    self.showingSafari = true
                            }
                            
                            if newsCount >= 11 {
                                BigNewsRow(entry: self.stockNews[10])
                                    .onTapGesture {
                                        self.url = self.stockNews[10].url
                                        self.showingSafari = true
                                }
                                
                                ForEach(11..<newsCount, id: \.self) { i in
                                    BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                        .onTapGesture {
                                            self.url = self.stockNews[i].url
                                            self.showingSafari = true
                                    }
                                }
                            } else {
                                ForEach(10..<newsCount, id: \.self) { i in
                                    BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                        .onTapGesture {
                                            self.url = self.stockNews[i].url
                                            self.showingSafari = true
                                    }
                                }
                            }
                        } else {
                            ForEach(8..<newsCount, id: \.self) { i in
                                BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                    .onTapGesture {
                                        self.url = self.stockNews[i].url
                                        self.showingSafari = true
                                }
                            }
                        }
                    } else {
                        ForEach(6..<newsCount, id: \.self) { i in
                            BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                                .onTapGesture {
                                    self.url = self.stockNews[i].url
                                    self.showingSafari = true
                            }
                        }
                    }
                } else {
                    ForEach(5..<newsCount, id: \.self) { i in
                        BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                            .onTapGesture {
                                self.url = self.stockNews[i].url
                                self.showingSafari = true
                        }
                    }
                }
            } else {
                ForEach(0..<newsCount, id: \.self) { i in
                    BasicNewsRow(entry: self.stockNews[i], orientation: "horizontal")
                        .onTapGesture {
                            self.url = self.stockNews[i].url
                            self.showingSafari = true
                    }
                }
            }
        }
        .padding()
    }
}

struct StockNewsView_Previews: PreviewProvider {
    static var previews: some View {
        StockNewsView(showingSafari: .constant(false), url: .constant(URL(string: "https://google.com")!), stockNews: [.mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock, .mock]).previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            .background(Color.black)
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
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                    .frame(width: UIScreen.main.bounds.width*0.43, height: UIScreen.main.bounds.width*0.3)
                    .cornerRadius(8)
                    
                    Text(self.entry.source)
                        .foregroundColor(Color("textColor"))
                        .font(.headline)
                        .italic()
                    Text(self.entry.title)
                        .foregroundColor(Color("textColor"))
                        .bold()
                        .font(.subheadline)
                    Spacer()
                    Text(self.entry.publishedSince)
                        .foregroundColor(Color("textColor"))
                        .font(.caption)
                }
                .frame(width: UIScreen.main.bounds.width*0.43, height: UIScreen.main.bounds.height*0.35)
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.entry.source)
                            .foregroundColor(Color("textColor"))
                            .font(.headline)
                            .italic()
                        Text(self.entry.title)
                            .foregroundColor(Color("textColor"))
                            .bold()
                            .font(.system(size: 18))
                        Spacer()
                        Text(self.entry.publishedSince)
                            .foregroundColor(Color("textColor"))
                            .font(.caption)
                    }
                    .frame(height: UIScreen.main.bounds.width*0.32)
                    
                    Spacer()
                    
                    URLImage(self.entry.image) { proxy in
                        proxy.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                    .frame(width: UIScreen.main.bounds.width*0.35, height: UIScreen.main.bounds.width*0.35)
                    .cornerRadius(8)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

struct BigNewsRow: View {
    let entry: StockNews
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                URLImage(self.entry.image) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
                .frame(width:  UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.7)
                .cornerRadius(8)
                
                Text(self.entry.source)
                    .foregroundColor(Color("textColor"))
                    .font(.headline)
                    .italic()
                Text(self.entry.title)
                    .foregroundColor(Color("textColor"))
                    .bold()
                    .font(.system(size: 25))
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                    .frame(height: 5)
                Text(self.entry.publishedSince)
                    .foregroundColor(Color("textColor"))
                    .font(.caption)
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }
}
