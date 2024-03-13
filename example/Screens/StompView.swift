//
//  StompView.swift
//  example
//
//  Created by Hee Seok Jung on 3/8/24.
//

import SwiftUI
import StompClientLib

struct StompView: View, StompClientDelegate {
    var room = 1
    var body: some View {
        let stompClient = StompClient(url: "ws://172.22.7.6:8084/socket/v1/ws_app", delegate: self)
        VStack {
            Button {
                stompClient.connect()
            } label: {
                Text("Connect to server")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                stompClient.subscibe(destination: "/chatting/\(room)")
            } label: {
                Text("Subscribe")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                stompClient.sendMessage(payloadObject: ["roomId" : "\(room)", "message" : "hello"])
            } label: {
                Text("Send message")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                stompClient.disconnect()
            } label: {
                Text("Disconnect to server")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
        }.padding()
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
    
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        
    }
    
    func serverDidSendPing() {
        
    }
}
