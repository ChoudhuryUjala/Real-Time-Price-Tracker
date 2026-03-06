//
//  PriceIndicatorView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 06/03/26.
//

import SwiftUI

struct PriceIndicatorView: View {
    
    var content: String
    var indicator: Bool
    
    var body: some View {
        Text(content)
        Text(indicator ? "↑" : "↓")
            .foregroundStyle(indicator ? .green : .red)
    }
}

#Preview {
    PriceIndicatorView(content: "$899", indicator: true)
}
