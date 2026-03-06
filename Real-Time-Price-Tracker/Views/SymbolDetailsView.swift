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
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.symbol?.id ?? "")
                    .font(.largeTitle)
                Spacer()
                Text(String(format: "%.2f",viewModel.symbol?.currentPrice ?? 0.0))
                Text(viewModel.symbol?.isHigh ?? false ? "↑" : "↓")
                    .foregroundStyle(viewModel.symbol?.isHigh ?? false ? .green : .red)
                
            }.padding(.bottom, 10)
                .padding(.top, 10)
            Text("About:")
                .font(.headline)
            Text(viewModel.symbol?.description ?? "")
                .font(.subheadline)
            Spacer()
        }.navigationTitle("Symbol details")
            .padding()
    }
}

#Preview {
    SymbolDetailsView(viewModel: SymbolDetailsViewModel(store: FeedStore(), symbolId: "NFLX"))
}
