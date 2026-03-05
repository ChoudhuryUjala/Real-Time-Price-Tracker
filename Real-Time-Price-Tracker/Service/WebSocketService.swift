//
//  WebSocketService.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation
import Combine

enum ServiceError: Error {
    case invalidURL
    case noService
    case dataIssue
}

class WebSocketService {
    
    var socket: URLSessionWebSocketTask?
    var tasks: [Task<Void, Never>] = []
    var wssURLString: String {
        "wss://ws.postman-echo.com/raw"
    }
    
    var store: FeedStore?
    
    func connect() throws {
        guard let wssURL = URL(string: wssURLString) else { throw ServiceError.invalidURL }
        socket = URLSession.shared.webSocketTask(with: wssURL)
        socket?.resume()
        ping()
        //send
        //receive
    }
    
    func disconnect() {
        tasks.forEach {$0.cancel()}
        socket?.cancel()
    }
    
    func ping() {
        socket?.sendPing { error in
            if let error = error {
                print("Ping failed: \(error)")
            } else {
                print("Ping successful")
            }
        }
    }
    
    func sendMessage() async throws {
        guard let symbols = store?.symbols else { throw ServiceError.dataIssue }
        
        do{
            while !Task.isCancelled {
               try await Task.sleep(for: .seconds(2))
                
                for symbol in symbols {
                    let symbolDataModel = WSSDataModel(id: symbol.id, newPrice: Double.random(in: 100...1000))
                    if let jsonData = try? JSONEncoder().encode(symbolDataModel) {
                        try await socket?.send(.data(jsonData))
                    }
                }
            }
        }catch {
           throw error
        }
    }
    
    func receiveMessage() async throws {
        for await data in dataStream() {
            try store?.updatePrice(symId: data.id, newPrice: data.newPrice)
        }
    }
    
    func dataStream() -> AsyncStream<WSSDataModel> {
        AsyncStream { continuation in
            func receive() {
                socket?.receive { result in
                    switch result {
                    case .success(.data(let data)):
                        do {
                            let receivedObj = try JSONDecoder().decode(WSSDataModel.self, from: data)
                            continuation.yield(receivedObj)
                        }catch{
                            continuation.finish()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        continuation.finish()
                    default:
                        break
                    }
                    receive()
                }
            }
            receive()
        }
    }
    
}
