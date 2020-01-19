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
    case let .addToPortfolio(stock, dividend):
        state.portfolioStocks.append(stock.ticker)
        state.allPortfolioStocks[stock.ticker] = stock
        state.sectorCompanies[stock.sector]?.append(stock)
        state.allUpcomingDivDates[dividend.ticker] = dividend.date
        
        state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
        appReducer(state: &state, action: .sortBy(sort: state.selectedSort))
        
    case let .removeFromPortfolio(offsets):
        let stock = state.allPortfolioStocks[state.portfolioStocks[offsets.first!]]!
        state.portfolioStocks.remove(atOffsets: offsets)
        state.sectorCompanies[stock.sector]?.removeAll(where: { $0 == stock })
        state.allPortfolioStocks.removeValue(forKey: stock.ticker)
        state.allHoldingsInfo.removeValue(forKey: stock.ticker)
        state.currentSharePrices.remove(atOffsets: offsets)
        
    case let .updateStartingDividend(index, value):
        let stock = state.allPortfolioStocks[state.portfolioStocks[index]]!
        let updatedStock = PortfolioStock(ticker: stock.ticker, fullName: stock.fullName, image: stock.image, startingDividend: value, currentDividend: stock.currentDividend, growth: ((stock.currentDividend / value) - 1.0) * 100, sector: stock.sector, frequency: stock.frequency)
        
        state.allPortfolioStocks[state.portfolioStocks[index]] = updatedStock
        
        if state.selectedSort == PortfolioSortState.startingDiv {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
            appReducer(state: &state, action: .sortBy(sort: state.selectedSort))
        }
        
    case let .updatePortfolio(stocks):
        stocks.forEach { state.allPortfolioStocks[$0.ticker] = $0 }
        if state.selectedSort == PortfolioSortState.currentDiv || state.selectedSort == PortfolioSortState.growth {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
            appReducer(state: &state, action: .sortBy(sort: state.selectedSort))
        }
        
    case let .updateUpcomingDivDates(dividends):
        dividends.forEach { state.allUpcomingDivDates[$0.ticker] = $0.date }
        
    // MARK: Portfolio Sort
    case let .sortBy(sort):
        let portfolioStocks = state.portfolioStocks.compactMap { state.allPortfolioStocks[$0] }
        if state.selectedSort != sort {
            state.selectedSort = sort
            state.sortDirection = SortDirection.down
        } else {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
        }
        switch sort {
        case PortfolioSortState.symbol:
            state.portfolioStocks = portfolioStocks.sorted(by: {
                SortDirection.comparator(sort: sort, direction: state.sortDirection, left: $0.ticker, right: $1.ticker)
            })
                .map { $0.ticker }
        case PortfolioSortState.name:
            state.portfolioStocks = portfolioStocks.sorted(by: {
                SortDirection.comparator(sort: sort, direction: state.sortDirection, left: $0.fullName, right: $1.fullName)
            })
                .map { $0.ticker }
        case PortfolioSortState.startingDiv:
            state.portfolioStocks = portfolioStocks.sorted(by: {
                SortDirection.comparator(sort: sort, direction: state.sortDirection, left: $0.startingDividend, right: $1.startingDividend)
            })
                .map { $0.ticker }
        case PortfolioSortState.currentDiv:
            state.portfolioStocks = portfolioStocks.sorted(by: {
                SortDirection.comparator(sort: sort, direction: state.sortDirection, left: $0.currentDividend, right: $1.currentDividend)
            })
                .map { $0.ticker }
        case PortfolioSortState.growth:
            state.portfolioStocks = portfolioStocks.sorted(by: {
                SortDirection.comparator(sort: sort, direction: state.sortDirection, left: $0.growth, right: $1.growth)
            })
                .map { $0.ticker }
        default:
            ()
        }
        
    // MARK: Search
    case let .setSearchResults(results):
        state.searchResult = results
        
    // MARK: Dividend Tracker
    case let .addHoldingInfo(ticker, holdingInfo):
        state.allHoldingsInfo[ticker] = holdingInfo
        
    case let .setCurrentSharePrices(prices):
        state.currentSharePrices = prices
        
    // MARK: Dividend Income
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
