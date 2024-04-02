//
//  URLSessionWebSocketTaskView.swift
//  example
//
//  Created by Hee Seok Jung on 4/2/24.
//

import SwiftUI

struct URLSessionWebSocketTaskView: View {
    let viewModel = URLSessionWebSocketTaskViewModel()
    
    var body: some View {
        VStack {
            Button {
                Log.debug("Connect Button")
                viewModel.connect()
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
                viewModel.disconnect()
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

class URLSessionWebSocketTaskViewModel {
    private var signalingClient: SignalingClient?
    
    init() {
        signalingClient = SignalingClient(url: "wss://172.22.7.6:8443/helloworld", delegate: self)
    }
    
    func connect() {
        signalingClient?.connect()
    }
    
    func disconnect() {
        signalingClient?.disconnect()
    }
}

extension URLSessionWebSocketTaskViewModel: SignalingDelegate {
    func webSocketDidConnect(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        Log.debug("[URLSessionWebSocketTaskViewModel::webSocketDidConnect] connected")
    }
    
    func webSocketDidDisconnect(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        Log.debug("[URLSessionWebSocketTaskViewModel::webSocketDidDisconnect] disconnected")
    }
    
    func webSocketReceviedData(didReceiveData data: Data) {
        Log.debug("[URLSessionWebSocketTaskViewModel::webSocketReceviedData] didReceiveData: \(data)")
    }
    
    func webSocketReceviedString(didReceiveStr string: String) {
        Log.debug("[URLSessionWebSocketTaskViewModel::webSocketReceviedString] didReceiveStr: \(string)")
    }
}
