//
//  ReachabilityService.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 06/03/26.
//

import Foundation
import Network

class ReachabilityService: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = false
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
