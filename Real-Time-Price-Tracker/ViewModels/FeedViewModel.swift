//
//  FeedViewModel.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation
@MainActor
protocol FeedVMProtocol {
    func fetchFeed()
}

@MainActor
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
        wssService.disconnect()
        bind()
        do {
            try wssService.connect()
        }catch {
            print(error.localizedDescription) 
        }
    }
    
    func bind() {
        store.$symbols.assign(to: &$symbols)
    }
    func fetchFeed() {
        restService.fetchFeed(store)
    }
    
}
