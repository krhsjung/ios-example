//
//  StompClient.swift
//  example
//
//  Created by Hee Seok Jung on 3/8/24.
//

import Foundation
import StompClientLib

protocol StompClientDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String)
    func stompClientDidDisconnect(client: StompClientLib!)
    func stompClientDidConnect(client: StompClientLib!)
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String)
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?)
    func serverDidSendPing()
}

class StompClient {
    private var socketClient = StompClientLib()
    private let url: String
    private let delegate: StompClientDelegate?
    
    init(url: String, delegate: StompClientDelegate? = nil) {
        self.url = url
        self.delegate = delegate
    }
    
    func connect() {
        self.socketClient.openSocketWithURLRequest(request: NSURLRequest(url: URL(string: url)!) , delegate: self)
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

extension StompClient : StompClientLibDelegate {
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        Log.info("[stompClient]\nheader : \(String(describing: header))\njsonBody : \(String(describing: jsonBody))\nakaStringBody : \(String(describing: stringBody))")
        self.delegate?.stompClient(client: client, didReceiveMessageWithJSONBody: jsonBody, akaStringBody: stringBody, withHeader: header, withDestination: destination)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        Log.info("[stompClientDidDisconnect]")
        self.delegate?.stompClientDidDisconnect(client: client)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        Log.info("[stompClientDidConnect]")
        self.delegate?.stompClientDidConnect(client: client)
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        Log.info("[serverDidSendReceipt] receiptId : \(receiptId)")
        self.delegate?.serverDidSendReceipt(client: client, withReceiptId: receiptId)
    }

    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        Log.info("[serverDidSendError]\nerror message - \(description)\ndetailed message - \(String(describing: message))")
        self.delegate?.serverDidSendError(client: client, withErrorMessage: description, detailedErrorMessage: message)
    }
    
    func serverDidSendPing() {
        Log.info("[serverDidSendPing]")
        self.delegate?.serverDidSendPing()
    }
}
