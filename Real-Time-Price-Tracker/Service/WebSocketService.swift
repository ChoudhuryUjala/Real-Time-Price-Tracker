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
    var tasks: [Task<Void, Error>] = []
    var wssURLString: String {
        "wss://ws.postman-echo.com/raw"
    }
    
    var store: FeedStore?
    
    func connect() throws {
        guard let wssURL = URL(string: wssURLString) else { throw ServiceError.invalidURL }
        socket = URLSession.shared.webSocketTask(with: wssURL)
        socket?.resume()
        ping()
        
        tasks.append(Task { try await receiveData()})
        tasks.append(Task { try await sendData()})
        
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
    
    func sendData() async throws {
        guard let symbols = await store?.symbols, !symbols.isEmpty else { throw ServiceError.dataIssue }
        do{
            while !Task.isCancelled {
               try await Task.sleep(for: .seconds(2))
                for symbol in symbols {
                    
                    let newPrice = String(Double.random(in: 100...1000))
                    let message = "\(symbol.id):\(newPrice)"
                    try await socket?.send(.string(message))
                }
            }
        } catch {
           throw error
        }
    }
    
    func receiveData() async throws {
        for await message in messageStream() {
            let wssModel: WSSDataModel = decode(message)
            try await store?.updatePrice(symId: wssModel.id, newPrice: wssModel.newPrice)
        }
    }
    
    func messageStream() -> AsyncStream<String> {
        AsyncStream { continuation in
            func receive() {
                socket?.receive { result in
                    switch result {
                    case .success(.string(let message)):
                        print(message)
                        continuation.yield(message)
                       
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
    
    func decode(_ message: String) -> WSSDataModel {
        let messageSubString = message.split(separator: ":")
        let id = String(messageSubString[0])
        let price = Double(messageSubString[1]) ?? 0.0
        return WSSDataModel(id: id, newPrice: price)
    }
    
}
