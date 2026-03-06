//
//  FeedStore.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation
@MainActor
class FeedStore: ObservableObject {
    @Published var symbols: [Symbol] = []
    
    
    func updatePrice(symId: String, newPrice: Double) {
        guard let outdatedIndex = symbols.firstIndex(where: {$0.id == symId}) else { return }
        let outdatedPrice = symbols[outdatedIndex].currentPrice
        symbols[outdatedIndex].previousPrice = outdatedPrice
        symbols[outdatedIndex].currentPrice = newPrice
    }
}
