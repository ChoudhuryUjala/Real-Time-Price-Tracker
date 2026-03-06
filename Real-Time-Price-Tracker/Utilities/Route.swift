//
//  Route.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation

enum Route: Hashable {
    case feed
    case symbolDetails(id:String)
}

class Routing: ObservableObject {
   @Published var path: [Route] = []
    
    func pop() {
        guard !path.isEmpty else { return }
        let _ = path.popLast()
    }
    
    func push(_ newPath: Route) {
        self.path.append(newPath)
    }
}
