//
//  WebSocketClient.swift
//  example
//
//  Created by Hee Seok Jung on 3/8/24.
//

import Foundation
import StompClientLib

class WebSocketClient {
    private var socketClient = StompClientLib()
    
    func connect(url: URL) {
        self.socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url) , delegate: self)
    }
    
    func subscibe(destination: String) {
        socketClient.subscribe(destination: destination)
    }
    
    func sendMessage(payloadObject : [String : Any]) {
        socketClient.sendJSONForDict(dict: payloadObject as AnyObject, toDestination: "/chatting")
    }
    
    func disconnect() {
        socketClient.disconnect()
    }

}

extension WebSocketClient : StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("[stompClient]\nheader : \(String(describing: header))\njsonBody : \(String(describing: jsonBody))\nakaStringBody : \(String(describing: stringBody))")
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("[stompClientDidDisconnect]")
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        print("[stompClientDidConnect]")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("[serverDidSendReceipt] receiptId : \(receiptId)")
    }

    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("[serverDidSendError]\nerror message - \(description)\ndetailed message - \(String(describing: message))")
    }
    
    func serverDidSendPing() {
        print("[serverDidSendPing]")
    }
}
