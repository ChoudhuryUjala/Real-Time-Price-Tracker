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
    @Published var isOnline: Bool = false
    @Published var isRunning: Bool = false
    
    var store: FeedStore
    var restService: FeedService
    var wssService: WebSocketService
    var reachability: ReachabilityService
    
    init(store: FeedStore, restService: FeedService, wssService: WebSocketService, reachability: ReachabilityService) {
        self.store = store
        self.restService = restService
        self.wssService = wssService
        self.wssService.store = store
        self.reachability = reachability
        
        disconnectFeed()
        bind()
        connectToFeed()
    }
    
    func bind() {
        store.$symbols.assign(to: &$symbols)
        reachability.$isConnected.assign(to: &$isOnline)
    }
    func fetchFeed() {
        restService.fetchFeed(store)
    }
    
    func connectToFeed() {
        do {
            try wssService.connect()
            isRunning = true
        }catch {
            isRunning = false
            print(error.localizedDescription)
        }
    }
    
    func disconnectFeed() {
        isRunning = false
        wssService.disconnect()
    }
    
    func toggleWSS() {
        if isRunning {
            connectToFeed()
        }else {
            disconnectFeed()
        }
    }
    
}
