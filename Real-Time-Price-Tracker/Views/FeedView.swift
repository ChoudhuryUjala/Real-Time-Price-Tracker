//
//  FeedView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct FeedView : View {
    @StateObject private var viewModel = FeedViewModel(store: FeedStore(), service: FeedService())
    
    var body: some View {
        List(viewModel.symbols){ symbol in
            FeedRowView(symbol: symbol)
        }.onAppear {
            viewModel.fetchFeed()
        }.navigationTitle("Feed")
    }
}

#Preview {
    FeedView()
}
