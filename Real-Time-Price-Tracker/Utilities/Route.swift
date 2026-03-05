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
    
    func pop() {}
    
    func push(_ newPath: Route) {
        self.path.append(newPath)
    }
}
