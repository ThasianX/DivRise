//
//  ScheduleContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 1/14/20.
//  Copyright © 2020 Kevin Li. All rights reserved.
//

import SwiftUI

struct ScheduleContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    
    @Binding var show: Bool
    
    var portfolioStocks: Set<PortfolioStock> {
        Set(store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        })
    }
    
    private var totalDividends: Double {
        store.state.portfolioStocks.map {
            if let holdingInfo = store.state.allHoldingsInfo[$0] {
                return holdingInfo.numOfShares * store.state.allPortfolioStocks[$0]!.currentDividend
            }
            return 0
        }
        .reduce(0, +)
    }
    
    
    var upcomingSchedule: [(id: String, stock: PortfolioStock, date: Date, amount: String)] {
        var upcoming = [(id: String, stock: PortfolioStock, date: Date, amount: String)]()
        
        for stock in portfolioStocks {
            if var date = store.state.allUpcomingDivDates[stock.ticker] {
                let freq = stock.frequency
                let numOfShares = store.state.allHoldingsInfo[stock.ticker]?.numOfShares
                
                if freq == "Quarterly" {
                    let dividend = (numOfShares != nil) ? String(format: "$%.2f", numOfShares! * stock.currentDividend/4) : "N/A"
                    upcoming.append((UUID().uuidString, stock, date, dividend))
                    for _ in 0...2 {
                        date = Calendar.current.date(byAdding: .month, value: 3, to: date)!
                        upcoming.append((UUID().uuidString, stock, date, dividend))
                    }
                } else if freq == "Semi-Annual" {
                    let dividend = (numOfShares != nil) ? String(format: "$%.2f", numOfShares! * stock.currentDividend/2) : "N/A"
                    upcoming.append((UUID().uuidString, stock, date, dividend))
                    for _ in 0...2 {
                        date = Calendar.current.date(byAdding: .month, value: 6, to: date)!
                        upcoming.append((UUID().uuidString, stock, date, dividend))
                    }
                } else {
                    let dividend = (numOfShares != nil) ? String(format: "$%.2f", numOfShares! * stock.currentDividend/12) : "N/A"
                    upcoming.append((UUID().uuidString, stock, date, dividend))
                    for _ in 0...2 {
                        date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
                        upcoming.append((UUID().uuidString, stock, date, dividend))
                    }
                }
            }
        }
        
        return upcoming
    }
    
    var body: some View {
        NavigationView {
            ScheduleView(upcomingSchedule: upcomingSchedule.sorted(by: { $0.date < $1.date }), yearlyDividendIncome: totalDividends)
                .navigationBarItems(
                    trailing: ExitButton(show: $show)
            )
            .navigationBarTitle(Text("Dividend Schedule"))
        }
        
    }
}
