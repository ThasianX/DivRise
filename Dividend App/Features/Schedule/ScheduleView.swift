//
//  ScheduleView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/15/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct ScheduleView: View {
    let upcomingSchedule: [(id: String, stock: PortfolioStock, date: Date, amount: String)]
    let yearlyDividendIncome: Double
    
    var body: some View {
        ZStack {
            Color("modalBackground").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Annual income: $\(yearlyDividendIncome, specifier: "%.2f")")
                    .foregroundColor(Color("textColor"))
                    .padding(.leading, 20)
                    .font(.headline)
                CustomDivider()
                
                if upcomingSchedule.isEmpty {
                    ZStack {
                        Text("Add stocks to display")
                            .foregroundColor(Color("textColor"))
                            .font(.headline)
                            .italic()
                        
                        List(ScheduleView.sampleSchedule, id: \.id) { tuple in
                            ScheduleListRow(stock: tuple.1, date: tuple.2, amount: tuple.3)
                        }
                        .opacity(0.3)
                        .disabled(true)
                    }
                    
                } else {
                    List(upcomingSchedule, id: \.id) { tuple in
                        ScheduleListRow(stock: tuple.1, date: tuple.2, amount: tuple.3)
                    }
                }
            }
        }
    }
}

extension ScheduleView {
    static let sampleSchedule: [(id: String, PortfolioStock, Date, String)] = [
        (id: "820D2FA1-9F2F-4A05-9B06-4D0C970A8038", DivRise.PortfolioStock(ticker: "AAPL", fullName: "Apple Inc.", image: "https://financialmodelingprep.com/images-New-jpg/AAPL.jpg", startingDividend: 3.0, currentDividend: 2.92, growth: -2.6666666666666727, sector: "Technology", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-03-28")!, "$405.15"),
        (id: "780D5BC6-3CB4-487C-9B3B-94EA99E2280D", stock: DivRise.PortfolioStock(ticker: "DIS", fullName: "The Walt Disney Company", image: "https://financialmodelingprep.com/images-New-jpg/DIS.jpg", startingDividend: 1.0, currentDividend: 1.76, growth: 76.0, sector: "Consumer Cyclical", frequency: "Quarterly"), date: Formatter.fullString.date(from: "2020-03-28")!, amount: "N/A"),
        (id: "A650D9C0-5CD4-40DE-9C48-923B37649573", DivRise.PortfolioStock(ticker: "JNJ", fullName: "Johnson & Johnson", image: "https://financialmodelingprep.com/images-New-jpg/JNJ.jpg", startingDividend: 1.0, currentDividend: 3.6, growth: 260.0, sector: "Healthcare", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-03-29")!, "N/A"),
        (id: "37997C26-36EE-41E3-AA9C-EBDB5612BEA2", DivRise.PortfolioStock(ticker: "T", fullName: "AT&T Inc.", image: "https://financialmodelingprep.com/images-New-jpg/T.jpg", startingDividend: 2.0, currentDividend: 2.04, growth: 2.0000000000000018, sector: "Communication Services", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-03-30")!, "$5.61"),
        (id: "47DA2D96-9DD0-4487-B88B-01E76D151F33", DivRise.PortfolioStock(ticker: "AAPL", fullName: "Apple Inc.", image: "https://financialmodelingprep.com/images-New-jpg/AAPL.jpg", startingDividend: 3.0, currentDividend: 2.92, growth: -2.6666666666666727, sector: "Technology", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-06-28")!, "$405.15"),
        (id: "D8D0CFD8-361F-43EC-A0DE-1666073D6039", stock: DivRise.PortfolioStock(ticker: "DIS", fullName: "The Walt Disney Company", image: "https://financialmodelingprep.com/images-New-jpg/DIS.jpg", startingDividend: 1.0, currentDividend: 1.76, growth: 76.0, sector: "Consumer Cyclical", frequency: "Quarterly"), date: Formatter.fullString.date(from: "2020-06-28")!, amount: "N/A"),
        (id: "757E3B6C-B16A-4FA8-9641-2CCCBB63277B", DivRise.PortfolioStock(ticker: "JNJ", fullName: "Johnson & Johnson", image: "https://financialmodelingprep.com/images-New-jpg/JNJ.jpg", startingDividend: 1.0, currentDividend: 3.6, growth: 260.0, sector: "Healthcare", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-06-29")!, "N/A"),
        (id: "CEEE1385-BC81-424F-9DE1-125EED76E0D6", DivRise.PortfolioStock(ticker: "T", fullName: "AT&T Inc.", image: "https://financialmodelingprep.com/images-New-jpg/T.jpg", startingDividend: 2.0, currentDividend: 2.04, growth: 2.0000000000000018, sector: "Communication Services", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-06-30")!, "$5.61"),
        (id: "41CE91BD-423B-4BD9-B3BA-8598C5623F02", DivRise.PortfolioStock(ticker: "AAPL", fullName: "Apple Inc.", image: "https://financialmodelingprep.com/images-New-jpg/AAPL.jpg", startingDividend: 3.0, currentDividend: 2.92, growth: -2.6666666666666727, sector: "Technology", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-09-28")!, "$405.15"),
        (id: "81B8F699-1BEB-4AA4-92F0-4A8A868D20D2", stock: DivRise.PortfolioStock(ticker: "DIS", fullName: "The Walt Disney Company", image: "https://financialmodelingprep.com/images-New-jpg/DIS.jpg", startingDividend: 1.0, currentDividend: 1.76, growth: 76.0, sector: "Consumer Cyclical", frequency: "Quarterly"), date: Formatter.fullString.date(from: "2020-09-28")!, amount: "N/A"),
        (id: "52126BF1-D167-48E1-99FE-E0B43DE6BDB5", DivRise.PortfolioStock(ticker: "JNJ", fullName: "Johnson & Johnson", image: "https://financialmodelingprep.com/images-New-jpg/JNJ.jpg", startingDividend: 1.0, currentDividend: 3.6, growth: 260.0, sector: "Healthcare", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-09-29")!, "N/A"),
        (id: "70FF63ED-2D0A-4887-AD2D-89323DC98B71", DivRise.PortfolioStock(ticker: "T", fullName: "AT&T Inc.", image: "https://financialmodelingprep.com/images-New-jpg/T.jpg", startingDividend: 2.0, currentDividend: 2.04, growth: 2.0000000000000018, sector: "Communication Services", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-09-30")!, "$5.61"),
        (id: "0741C422-AFF2-4C80-A19C-FF94EC0A2099", DivRise.PortfolioStock(ticker: "AAPL", fullName: "Apple Inc.", image: "https://financialmodelingprep.com/images-New-jpg/AAPL.jpg", startingDividend: 3.0, currentDividend: 2.92, growth: -2.6666666666666727, sector: "Technology", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-12-28")!, "$405.15"),
        (id: "4F82E320-A325-481B-B9A3-7D006F194DC0", stock: DivRise.PortfolioStock(ticker: "DIS", fullName: "The Walt Disney Company", image: "https://financialmodelingprep.com/images-New-jpg/DIS.jpg", startingDividend: 1.0, currentDividend: 1.76, growth: 76.0, sector: "Consumer Cyclical", frequency: "Quarterly"), date: Formatter.fullString.date(from: "2020-12-28")!, amount: "N/A"),
        (id: "ACFAEA69-BC34-47D2-9AF6-12B5062BD227", DivRise.PortfolioStock(ticker: "JNJ", fullName: "Johnson & Johnson", image: "https://financialmodelingprep.com/images-New-jpg/JNJ.jpg", startingDividend: 1.0, currentDividend: 3.6, growth: 260.0, sector: "Healthcare", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-12-29")!, "N/A"),
        (id: "A5F2BF08-C439-4C3F-8405-C91D1A1A4EFA", DivRise.PortfolioStock(ticker: "T", fullName: "AT&T Inc.", image: "https://financialmodelingprep.com/images-New-jpg/T.jpg", startingDividend: 2.0, currentDividend: 2.04, growth: 2.0000000000000018, sector: "Communication Services", frequency: "Quarterly"), Formatter.fullString.date(from: "2020-12-30")!, "$5.61")
    ]
}

struct ScheduleListRow: View {
    let stock: PortfolioStock
    let date: Date
    let amount: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.ticker)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("textColor"))
                
                Text(stock.fullName)
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(amount)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundColor(Color("textColor"))
                
                Text(date.mediumStyle)
                    .font(.system(size: 15))
                    .foregroundColor(Color.gray)
            }
        }
    }
}
