//
//  WebSocketView.swift
//  example
//
//  Created by Hee Seok Jung on 3/13/24.
//

import SwiftUI
import Starscream

struct WebSocketView: View, WebSocketClientDelegate {
    
    var body: some View {
        let websocketClient = WebSocketClient(url: "http://172.22.7.6:8084/socket/v1/ws_app", delegate: self)
        VStack {
            Button {
                Log.debug("Connect Button")
                websocketClient.connect()
            } label: {
                Text("Connect to server")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(.black)
                    .cornerRadius(15)
            }
            Button {
                Log.debug("Disconnect Button")
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
    
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        switch event {
            case .connected(let headers):
                break
            case .disconnected(let reason, let code):
                break
            case .text(let string):
                break
            case .binary(let data):
                break
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                break
            case .error(let error):
                break
            case .peerClosed:
                break
        }
    }
}
