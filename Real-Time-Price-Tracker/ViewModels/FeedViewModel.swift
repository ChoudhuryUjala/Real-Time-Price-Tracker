//
//  FeedViewModel.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation

protocol FeedVMProtocol {
    func fetchFeed()
}

class FeedViewModel: FeedVMProtocol, ObservableObject {
    
    @Published var symbols: [Symbol] = []
    
    var store: FeedStore
    var service: FeedService
    
    init(store: FeedStore, service: FeedService) {
        self.store = store
        self.service = service
        store.$symbols.assign(to: &$symbols)
    }
    
    func fetchFeed() {
        if store.symbols.isEmpty {
            service.fetchFeed(store)
        } else {
            //wss connect
        }
    }
    
}
