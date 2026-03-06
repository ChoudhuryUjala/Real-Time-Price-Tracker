//
//  WebSocketService.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation
import Combine

enum ServiceError: Error {
    case error(reason: String)
}

class WebSocketService {
    
    var socket: URLSessionWebSocketTask?
    var wssURLString: String {
        "wss://ws.postman-echo.com/raw"
    }
    var publisher = PassthroughSubject<WSSDataModel, Never>()
    let symbols = CurrentValueSubject<[Symbol], Never>([])
    let errorPublisher = PassthroughSubject<ServiceError, Never>()
    
    var cancellables = Set<AnyCancellable>()
    
    
    func connect() {
        guard let wssURL = URL(string: wssURLString) else { return }
        socket = URLSession.shared.webSocketTask(with: wssURL)
        socket?.resume()
        ping()
        
        receiveMessage()
        sendMessage()
    }
    
    func disconnect() {
        cancellables.forEach {$0.cancel()}
        cancellables.removeAll()
        socket?.cancel()
    }
    
    private func ping() {
        socket?.sendPing { error in
            if let error = error {
                print("Ping failed: \(error)")
            } else {
                print("Ping successful")
            }
        }
    }
    
    private func sendMessage() {
        Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                let currentSymbols = self.symbols.value
                guard !currentSymbols.isEmpty else {
                    return
                }
                DispatchQueue.global(qos: .background).async {
                    for symbol in currentSymbols {
                        let price = Double.random(in: 100...1000)
                        let message = "\(symbol.id):\(price)"
                        self.socket?.send(.string(message)) { error in
                            if let error = error { print(error)
                                self.handleError(error)
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func receiveMessage() {
        func receive() {
            socket?.receive { result in
                switch result {
                case .success(.string(let message)):
                    print(message)
                    DispatchQueue.main.async {
                        let wssModel: WSSDataModel = self.decode(message)
                        self.publisher.send(wssModel)
                    }
                    receive()
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.handleError(error)
                    }
                default:
                    break
                }
            }
        }
        receive()
    }
    
    private func decode(_ message: String) -> WSSDataModel {
        let messageSubString = message.split(separator: ":")
        let id = String(messageSubString[0])
        let price = Double(messageSubString[1]) ?? 0.0
        return WSSDataModel(id: id, newPrice: price)
    }
    
    private func handleError(_ error: Error) {
        let nserror = error as NSError
        if nserror.domain == NSPOSIXErrorDomain && nserror.code == 57 {
            print("Manually disconnected, ignoring failure")
            return
        } else {
            DispatchQueue.main.async {
                self.errorPublisher.send(.error(reason: error.localizedDescription))
            }
        }
        print(error.localizedDescription)
    }
    
    
}
