//
//  AppReducer.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
    // MARK: Notifications
    case let .toggleNotifications(enabled):
        state.notificationsSet = enabled
        
    case let .setNotificationDay(day):
        state.notificationDay = day
        
    case let .setNotificationTime(time):
        state.notificationTime = time
        
    // MARK: Portfolio
    case let .addToPortfolio(stock):
        state.portfolioStocks.append(stock.ticker)
        state.allPortfolioStocks[stock.ticker] = stock
        state.sectorCompanies[stock.sector]?.append(stock)
        
    case let .removeFromPortfolio(offsets):
        let stock = state.allPortfolioStocks[state.portfolioStocks[offsets.first!]]!
        state.portfolioStocks.remove(atOffsets: offsets)
        state.sectorCompanies[stock.sector]?.removeAll(where: { $0 == stock })
       
    case let .moveStockInPortfolio(previous, current):
        state.portfolioStocks.move(fromOffsets: previous, toOffset: current)
        
    case let .updateStartingDividend(index, value):
        let stock = state.allPortfolioStocks[state.portfolioStocks[index]]!
        let updatedStock = PortfolioStock(ticker: stock.ticker, fullName: stock.fullName, image: stock.image, startingDividend: value, currentDividend: stock.currentDividend, growth: ((stock.currentDividend / value) - 1.0) * 100, sector: stock.sector)
        
        state.allPortfolioStocks[state.portfolioStocks[index]] = updatedStock
        
    case let .updatePortfolio(stocks):
        stocks.forEach { state.allPortfolioStocks[$0.ticker] = $0 }
        
    case let .addUpcomingDivDate(dividend):
        state.allUpcomingDivDates[dividend.ticker] = dividend.date
        
    case let .updateUpcomingDivDates(dividends):
        dividends.forEach { state.allUpcomingDivDates[$0.ticker] = $0.date }
        
    // MARK: Search
    case let .setSearchResults(results):
        state.searchResult = results
        
    // MARK: Dividend Tracker
    case let .addMonthlyDividend(record, dividend):
        if state.allMonthlyRecords.last == record {
            let lastIndex = state.allMonthlyRecords.count - 1
            state.allMonthlyRecords[lastIndex] = record
            state.allMonthlyDividends[lastIndex] = dividend
        } else {
            state.allMonthlyRecords.append(record)
            state.allMonthlyDividends.append(dividend)
        }
        
    // MARK: Stock Detail
    case let .setDetailStock(detail):
        state.currentDetailStock = detail
        
    case let .setSelectedPeriod(period):
        state.selectedPeriod = period
        
    case let.setAttributeNames(attributeNames):
        state.attributeNames = attributeNames
        
    case let .setStockNews(news):
        state.currentStockNews = news
    }
}
