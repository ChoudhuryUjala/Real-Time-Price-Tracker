//
//  ConnectionStatusView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 06/03/26.
//

import SwiftUI

struct ConnectionStatusView: View {
    
    let isConnected: Bool
    @Binding var isRunning: Bool
    let toggleAction: (Bool) -> Void
    
    var body: some View {
        HStack{
            Text(isConnected ? "🟢 Connected" : "🔴 Disconnected")
                .fontWeight(.semibold)
            Spacer()
            Toggle(isOn: $isRunning) {
                Text(isRunning ? "Stop Feed" : "Start Feed")
                    .fontWeight(.semibold)
            }
            .disabled(!isConnected)
            .onChange(of: isRunning) { oldValue, newValue in
                toggleAction(newValue)
            }
        }.padding()
            .background(.ultraThinMaterial)
            .overlay(Divider(), alignment: .bottom)
    }
}
