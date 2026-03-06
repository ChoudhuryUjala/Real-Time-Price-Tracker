//
//  RootView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var route: Routing
    
    @StateObject private var store : FeedStore
    @StateObject private var reachability: ReachabilityService
    
    private var feedService = FeedService()
    
    init() {
        _store = StateObject(wrappedValue: FeedStore())
        _reachability = StateObject(wrappedValue: ReachabilityService())
        self.feedService = FeedService()
    }
    
    var body: some View {
        NavigationStack(path: $route.path) {
            FeedView(viewModel: FeedViewModel(store: store,
                                              restService: feedService,
                                              wssService: WebSocketService(),
                                              reachability: reachability))
            .navigationDestination(for: Route.self) { path in
                switch path {
                case .feed:
                    FeedView(viewModel: FeedViewModel(store: store,
                                                      restService: feedService,
                                                      wssService: WebSocketService(),
                                                      reachability: reachability))
                case .symbolDetails(let id):
                    SymbolDetailsView(viewModel: SymbolDetailsViewModel(store: store,
                                                                        symbolId: id))
                }
            }
        }
    }
}

#Preview {
    RootView()
}
