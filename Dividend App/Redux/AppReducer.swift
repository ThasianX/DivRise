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
        
        switch state.selectedSort {
        case PortfolioSortState.symbol:
            appReducer(state: &state, action: .sortBySymbol)
        case PortfolioSortState.name:
            appReducer(state: &state, action: .sortByName)
        case PortfolioSortState.startingDiv:
            appReducer(state: &state, action: .sortByStartingDiv)
        case PortfolioSortState.currentDiv:
            appReducer(state: &state, action: .sortByCurrentDiv)
        case PortfolioSortState.growth:
            appReducer(state: &state, action: .sortByGrowth)
        default:
            ()
        }
        
    case let .removeFromPortfolio(offsets):
        let stock = state.allPortfolioStocks[state.portfolioStocks[offsets.first!]]!
        state.portfolioStocks.remove(atOffsets: offsets)
        state.sectorCompanies[stock.sector]?.removeAll(where: { $0 == stock })
        
    case let .moveStockInPortfolio(previous, current):
        state.portfolioStocks.move(fromOffsets: previous, toOffset: current)
        
    case let .updateStartingDividend(index, value):
        let stock = state.allPortfolioStocks[state.portfolioStocks[index]]!
        let updatedStock = PortfolioStock(ticker: stock.ticker, fullName: stock.fullName, image: stock.image, startingDividend: value, currentDividend: stock.currentDividend, growth: ((stock.currentDividend / value) - 1.0) * 100, sector: stock.sector, frequency: stock.frequency)
        
        state.allPortfolioStocks[state.portfolioStocks[index]] = updatedStock
        
    case let .updatePortfolio(stocks):
        stocks.forEach { state.allPortfolioStocks[$0.ticker] = $0 }
        
    case let .updateUpcomingDivDates(dividends):
        dividends.forEach { state.allUpcomingDivDates[$0.ticker] = $0.date }
        
    // MARK: Portfolio Sort
    case .sortBySymbol:
        let portfolioStocks = state.portfolioStocks.compactMap { state.allPortfolioStocks[$0] }
        state.portfolioStocks = portfolioStocks.sorted(by: { $0.ticker < $1.ticker }).map { $0.ticker }
        if state.selectedSort != PortfolioSortState.symbol {
            state.selectedSort = PortfolioSortState.symbol
            state.sortDirection = SortDirection.down
        } else {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
        }
        
    case .sortByName:
        let portfolioStocks = state.portfolioStocks.compactMap { state.allPortfolioStocks[$0] }
        state.portfolioStocks = portfolioStocks.sorted(by: { $0.fullName < $1.fullName }).map { $0.ticker }
        state.selectedSort = PortfolioSortState.name
        if state.selectedSort != PortfolioSortState.name {
            state.selectedSort = PortfolioSortState.name
            state.sortDirection = SortDirection.down
        } else {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
        }
        
    case .sortByStartingDiv:
        let portfolioStocks = state.portfolioStocks.compactMap { state.allPortfolioStocks[$0] }
        state.portfolioStocks = portfolioStocks.sorted(by: { $0.startingDividend > $1.startingDividend }).map { $0.ticker }
        state.selectedSort = PortfolioSortState.startingDiv
        if state.selectedSort != PortfolioSortState.startingDiv {
            state.selectedSort = PortfolioSortState.startingDiv
            state.sortDirection = SortDirection.down
        } else {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
        }
        
    case .sortByCurrentDiv:
        let portfolioStocks = state.portfolioStocks.compactMap { state.allPortfolioStocks[$0] }
        state.portfolioStocks = portfolioStocks.sorted(by: { $0.currentDividend > $1.currentDividend }).map { $0.ticker }
        state.selectedSort = PortfolioSortState.currentDiv
        if state.selectedSort != PortfolioSortState.currentDiv {
            state.selectedSort = PortfolioSortState.currentDiv
            state.sortDirection = SortDirection.down
        } else {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
        }
        
    case .sortByGrowth:
        let portfolioStocks = state.portfolioStocks.compactMap { state.allPortfolioStocks[$0] }
        state.portfolioStocks = portfolioStocks.sorted(by: { $0.growth > $1.growth }).map { $0.ticker }
        state.selectedSort = PortfolioSortState.growth
        if state.selectedSort != PortfolioSortState.growth {
            state.selectedSort = PortfolioSortState.growth
            state.sortDirection = SortDirection.down
        } else {
            state.sortDirection = SortDirection.toggle(direction: state.sortDirection)
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
