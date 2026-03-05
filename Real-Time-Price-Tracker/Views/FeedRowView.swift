//
//  FeedRowView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct FeedRowView: View {
    @EnvironmentObject var route: Routing
    
    var symbol: Symbol
        
    var body: some View {
        HStack {
            Text("\(symbol.id)")
                .font(.headline)
            Spacer()
            Text(String(format: "%.2f", symbol.currentPrice))
            Text(symbol.isHigh ? "↑" : "↓")
                .foregroundStyle(symbol.isHigh ? .green : .red)
        }.padding()
            .onTapGesture {
                route.push(.symbolDetails(id: symbol.id))
            }
    }
}

#Preview {
    FeedRowView(symbol: Symbol(id: "XXX", currentPrice: 569.10, previousPrice: 478.78, description: "Text symbol is since eternity"))
}
