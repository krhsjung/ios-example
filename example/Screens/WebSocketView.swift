//
//  WebSocketView.swift
//  example
//
//  Created by Hee Seok Jung on 3/8/24.
//

import SwiftUI
import StompClientLib

struct WebSocketView: View {
    
    var websocketClient = WebSocketClient()
    var room = 1
    var body: some View {
        VStack {
            Button {
                websocketClient.connect(url: URL(string: "ws://172.22.7.6:8084/socket/v1/ws_app")!)
            } label: {
                Text("Connect to server")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                websocketClient.subscibe(destination: "/chatting/\(room)")
            } label: {
                Text("Subscribe")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                websocketClient.sendMessage(payloadObject: ["roomId" : "\(room)", "message" : "hello"])
            } label: {
                Text("Send message")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                websocketClient.disconnect()
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
}
