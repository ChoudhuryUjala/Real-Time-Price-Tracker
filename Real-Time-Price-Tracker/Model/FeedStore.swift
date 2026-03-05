//
//  FeedStore.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation

class FeedStore: ObservableObject {
    @Published var symbols: [Symbol] = []
}
