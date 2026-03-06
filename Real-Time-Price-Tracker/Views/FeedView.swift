//
//  FeedView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct FeedView : View {
    
    @StateObject var viewModel: FeedViewModel
    @EnvironmentObject var route: Routing

    var body: some View {
        VStack(spacing: 0) {
            ConnectionStatusView(isConnected: viewModel.isOnline,
                                 isRunning: $viewModel.isRunning) { isOn in
                viewModel.toggleWSS()
            }
            List(viewModel.symbols){ symbol in
                FeedRowView(symbol: symbol)
                    .contentShape(Rectangle()) 
                    .onTapGesture {
                        route.push(.symbolDetails(id: symbol.id))
                    }
            }.onAppear {
                viewModel.fetchFeed()
            }.navigationTitle("Feed")
        }
    }
}

#Preview {
    FeedView(viewModel: FeedViewModel(store: FeedStore(),
                                      restService: FeedService(),
                                      wssService: WebSocketService(),
                                      reachability: ReachabilityService()))
}
