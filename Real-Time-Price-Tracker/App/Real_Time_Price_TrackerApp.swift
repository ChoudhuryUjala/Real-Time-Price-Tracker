//
//  Real_Time_Price_TrackerApp.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import SwiftUI

@main
struct Real_Time_Price_TrackerApp: App {
    // route keeps navigation state
    @StateObject private var route = Routing()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(route)
        }
    }
}
