//
//  PortfolioContainerView.swift
//  Dividend App
//
//  Created by Kevin Li on 12/23/19.
//  Copyright © 2019 Kevin Li. All rights reserved.
//

import SwiftUI

struct PortfolioContainerView: View {
    @EnvironmentObject var store: Store<AppState, AppAction>
    @State private var showingDetail = false
    @State private var bottomSheetShown = false
    @State private var selectedIndex = 0
    
    private var portfolioStocks: [PortfolioStock] {
        store.state.portfolioStocks.compactMap {
            store.state.allPortfolioStocks[$0]
        }
    }
    
    var body: some View {
        ZStack {
            PortfolioView(showingDetail: $showingDetail, selectedIndex: $selectedIndex, portfolioStocks: portfolioStocks, onDelete: onDelete, onMove: onMove)
                .navigationBarTitle(Text("Portfolio"))
                .onAppear(perform: reloadDividends)
                .sheet(isPresented: self.$showingDetail) {
                    PortfolioDetailContainerView(portfolioStock: self.portfolioStocks[self.selectedIndex], selectedPeriod: self.store.state.selectedPeriod, attributeNames: self.store.state.attributeNames)
                        .environmentObject(self.store)
            }
//            .navigationBarItems(
//                leading: EditButton(),
//                trailing:
//                NavigationLink(destination: AddStockContainerView().environmentObject(self.store)) {
//                    Image(systemName: "magnifyingglass")
//                }
//            )
            
//            GeometryReader { geometry in
//                BottomSheetView(
//                    isOpen: self.$bottomSheetShown,
//                    maxHeight: geometry.size.height * 0.9
//                ) {
//                    PortfolioInfoContainerView(portfolioStocks: self.portfolioStocks, upcomingDividendDates: self.upcomingDividendDates)
//                        .onAppear(perform: self.reloadDividendDates)
//                        .environmentObject(self.store)
//                }
//            }.edgesIgnoringSafeArea(.all)
        }
    }
    
    private func onDelete(at offsets: IndexSet) {
        store.send(.removeFromPortfolio(offsets: offsets))
    }
    
    private func onMove(from source: IndexSet, to destination: Int) {
        store.send(.moveStockInPortfolio(previous: source, current: destination))
    }
    
    private func reloadDividends() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.store.send(.setSearchResults(results: []))
            self.store.send(updatePortfolio(portfolioStocks: self.portfolioStocks))
        }
    }
    
    private func reloadDividendDates() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.store.send(updateNextDividendDate(portfolioStocks: self.portfolioStocks))
        }
    }
}

