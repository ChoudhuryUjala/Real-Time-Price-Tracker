//
//  PriceIndicators.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 06/03/26.
//

import SwiftUI

struct PriceIndicators: View {
    
    var content: String
    var indicator: Bool
    
    var body: some View {
        Text(content)
        Text(indicator ? "↑" : "↓")
            .foregroundStyle(indicator ? .green : .red)
    }
}

#Preview {
    PriceIndicators(content: "$899", indicator: true)
}
