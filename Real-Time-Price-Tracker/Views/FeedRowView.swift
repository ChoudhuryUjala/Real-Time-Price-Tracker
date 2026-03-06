//
//  FeedRowView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

struct FeedRowView: View {
    
    var symbol: Symbol
        
    var body: some View {
        HStack {
            Text("\(symbol.id)")
                .font(.headline)
            Spacer()
            PriceIndicators(content: symbol.decoratedCurrentPrice, indicator: symbol.isHigh)
        }.padding()
    }
}

#Preview {
    FeedRowView(symbol: Symbol(id: "XXX", currentPrice: 569.10, previousPrice: 478.78, description: "Text symbol is since eternity"))
}
