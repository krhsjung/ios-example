//
//  WebSocketClient.swift
//  example
//
//  Created by Hee Seok Jung on 3/13/24.
//

import Foundation
import Starscream

protocol WebSocketClientDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient)
}

class WebSocketClient {
    private let url: String
    private var socket: WebSocket?
    private var isConnected: Bool = false
    private var delegate: WebSocketClientDelegate?
    
    init(url: String, delegate: WebSocketClientDelegate? = nil) {
        self.url = url
        self.delegate = delegate
    }
    
    func connect() {
        var request = URLRequest(url: URL(string: url)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func sendMessage(data: Data, completion: (() -> ())? = nil) {
        socket?.write(data: data, completion: completion)
    }
    
    func sendMessage(string: String, completion: (() -> ())? = nil) {
        socket?.write(string: string, completion: completion)
    }
    
    func sendMessage(ping: Data, completion: (() -> ())? = nil) {
        socket?.write(ping: ping, completion: completion)
    }
    
    func sendMessage(pong: Data, completion: (() -> ())? = nil) {
        socket?.write(pong: pong, completion: completion)
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    func disconnect(closeCode: UInt16) {
        socket?.disconnect(closeCode: closeCode)
    }
}

extension WebSocketClient : WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        Log.info("didReceive - \(event)")
        delegate?.didReceive(event: event, client: client)
    }
}
