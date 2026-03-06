//
//  SymbolDetailsView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct SymbolDetailsView: View {
    
    @StateObject var viewModel: SymbolDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let symbol = viewModel.symbol {
                HStack {
                    Text(symbol.id)
                        .font(.largeTitle)
                    Spacer()
                    PriceIndicators(content: symbol.decoratedCurrentPrice, indicator: symbol.isHigh)
                }
                
                if let description = viewModel.symbol?.description, !description.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("About:")
                            .font(.headline)
                        Text(description)
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }.navigationTitle("Symbol details")
            .padding()
    }
}

#Preview {
    SymbolDetailsView(viewModel: SymbolDetailsViewModel(store: FeedStore(), symbolId: "NFLX"))
}
