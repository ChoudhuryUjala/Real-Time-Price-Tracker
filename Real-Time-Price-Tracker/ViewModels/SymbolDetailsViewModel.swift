//
//  SymbolDetailsViewModel.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation

@MainActor
class SymbolDetailsViewModel: ObservableObject {
    @Published var symbol: Symbol?
    
    var store: FeedStore
    var symbolId: String
    
    init(store: FeedStore, symbolId: String) {
        self.store = store
        self.symbolId = symbolId
        bind()
    }
    
    private func bind() {
        store.$symbols
            .map{$0.first{ $0.id == self.symbolId}}
            .assign(to: &$symbol)
    }
}
