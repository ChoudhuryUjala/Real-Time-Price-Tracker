//
//  FeedViewModel.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation
import Combine

@MainActor
class FeedViewModel: ObservableObject {
    
    @Published var symbols: [Symbol] = []
    @Published var isOnline: Bool = false
    @Published var isRunning: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    var store: FeedStore
    var restService: FeedService
    var wssService: WebSocketService
    var reachability: ReachabilityService
    
    init(store: FeedStore, restService: FeedService, wssService: WebSocketService, reachability: ReachabilityService) {
        self.store = store
        self.restService = restService
        self.wssService = wssService
        self.reachability = reachability
        
        disconnectFeed()
        bind()
        connectToFeed()
    }
    
    private func bind() {
        store.$symbols.assign(to: &$symbols)
        reachability.$isConnected.assign(to: &$isOnline)
        
        wssService.publisher.sink (receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                self?.isRunning = false
            case .failure(let error):
                print("Error - \(error)")
                self?.isRunning = false
            }
        }, receiveValue: {[weak self] model in
            self?.store.updatePrice(symId: model.id, newPrice: model.newPrice)
        })
        .store(in: &cancellables)
        
        wssService.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                print("WSS Error:", error)
                self?.isRunning = false
            }
            .store(in: &cancellables)
        
        $symbols
            .sink { [weak self] symbols in
                self?.wssService.symbols.send(symbols)
            }
            .store(in: &cancellables)
    }
    
    func fetchFeed() {
        restService.fetchFeed(store)
    }
    
    private func connectToFeed() {
        wssService.connect()
        isRunning = true
    }
    
    private func disconnectFeed() {
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
