//
//  AppReducer.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    case let .toggleNotifications(enabled):
        state.notificationsSet = enabled
        
    case let .addToPortfolio(stock):
        if !state.allPortfolioStocks.keys.contains(stock.ticker) {
            Logger.info("Doesn't contain stock")
            state.portfolioStocks.append(stock.ticker)
        }
        state.allPortfolioStocks[stock.ticker] = stock
        Logger.info("\(state.allPortfolioStocks)")
        
    case let .removeFromPortfolio(offsets):
        state.portfolioStocks.remove(atOffsets: offsets)
        
    case let .moveStockInPortfolio(previous, current):
        state.portfolioStocks.move(fromOffsets: previous, toOffset: current)

    case let .updateStartingDividend(double, index):
        let stock = state.allPortfolioStocks[state.portfolioStocks[index]]!
        let updatedStock = PortfolioStock(ticker: stock.ticker, fullName: stock.fullName, startingDividend: double, currentDividend: stock.currentDividend, growth: ((stock.currentDividend / double) - 1.0) * 100)
        
        state.allPortfolioStocks[state.portfolioStocks[index]] = updatedStock
        
    case let .updatePortfolio(stocks):
        stocks.forEach { state.allPortfolioStocks[$0.ticker] = $0 }
        
    case let .updateUpcomingDivDates(dates):
        Logger.info("\(dates)")
        dates.forEach { state.allUpcomingDivDates[$0.ticker] = $0.date }
        Logger.info("\(state.allUpcomingDivDates)")
        
    case let .setSearchResults(results):
        state.searchResult = results
        
    case let .addMonthlyDividend(record, dividend):
        if state.allMonthlyRecords.last == record {
            let lastIndex = state.allMonthlyRecords.count - 1
            state.allMonthlyRecords[lastIndex] = record
            state.allMonthlyDividends[lastIndex] = dividend
        } else {
            state.allMonthlyRecords.append(record)
            state.allMonthlyDividends.append(dividend)
        }

    case let .setDetailStock(detail):
        state.currentDetailStock = detail
        
    case let .setStockNews(news):
        state.currentStockNews = news
        
    case let .setSelectedPeriod(period):
        state.selectedPeriod = period
        
    case let.setAttributeNames(attributeNames):
        state.attributeNames = attributeNames
    }
}
