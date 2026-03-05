//
//  Symbol.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation

struct Symbol: Identifiable {
    var id: String
    var currentPrice: Double
    var previousPrice: Double
    var description: String
    
    mutating func updatePrice(_ newPrice: Double) {
        self.previousPrice = currentPrice
        self.currentPrice = newPrice
    }
}

extension Symbol {
    var isHigh: Bool {
        return (currentPrice > previousPrice)
    }
}




