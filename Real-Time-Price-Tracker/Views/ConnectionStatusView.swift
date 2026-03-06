//
//  ConnectionStatusView.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 06/03/26.
//

import SwiftUI

struct ConnectionStatusView: View {
    
    var isConnected: Bool
    @Binding var isRunning: Bool
    let toggleAction: (Bool) -> Void
    
    var body: some View {
        HStack{
            let _ = print("Connected: \(isConnected)")
            Text(isConnected ? "🟢 Connected" : "🔴 Disconnected")
                .fontWeight(.semibold)
            Spacer()
            Toggle(isOn: $isRunning) {}
            .disabled(!isConnected)
            .onChange(of: isRunning) { oldValue, newValue in
                toggleAction(newValue)
            }
        }.padding()
        .overlay(Divider(), alignment: .bottom)
    }
}
