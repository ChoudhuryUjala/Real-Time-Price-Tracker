//
//  RootView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var route: Routing
    
    var body: some View {
        NavigationStack(path: $route.path) {
            FeedView()
                .navigationDestination(for: Route.self) { path in
                    switch path {
                    case .feed:
                        FeedView()
                    case .symbolDetails:
                        SymbolDetailsView()
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
