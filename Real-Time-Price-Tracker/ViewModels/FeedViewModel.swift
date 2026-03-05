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
    var restService: FeedService
    var wssService: WebSocketService
    
    init(store: FeedStore, restService: FeedService, wssService: WebSocketService) {
        self.store = store
        self.restService = restService
        self.wssService = wssService
        self.wssService.store = store
        
        store.$symbols.assign(to: &$symbols)
        do {
            
            try wssService.connect()
        }catch {
            print(error.localizedDescription) // improvise later
        }
    }
    
    func fetchFeed() {
        restService.fetchFeed(store)
    }
    
}
