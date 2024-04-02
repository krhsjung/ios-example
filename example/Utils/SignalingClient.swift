//
//  SignalingClient.swift
//  example
//
//  Created by Hee Seok Jung on 4/2/24.
//

import Foundation

protocol SignalingDelegate: AnyObject {
    func webSocketDidConnect(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?)
    func webSocketDidDisconnect(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?)
    func webSocketReceviedData(didReceiveData data: Data)
    func webSocketReceviedString(didReceiveStr string: String)
}

class SignalingClient : NSObject, URLSessionWebSocketDelegate {
    private let url: String
    private weak var delegate: SignalingDelegate?
    private var socket: URLSessionWebSocketTask?
    var onReceiveClosure: ((String?, Data?) -> ())?
    
    init(url: String, delegate: SignalingDelegate? = nil) {
        self.url = url
        self.delegate = delegate
    }

    func connect() {
        Log.debug("[SignalingClient::connect]")
        if(socket != nil){
            return
        }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        socket = session.webSocketTask(with: URL(string: url)!)
        socket?.resume()
        self.receive()
    }

    @objc func disconnect() {
        Log.debug("[SignalingClient::disconnect]")
        socket?.cancel(with: .normalClosure, reason: "You've Closed The Connection".data(using: .utf8))
    }

    func sendMessage(string: String) {
        Log.debug("[SignalingClient::sendMessage] message : \(string)")
        _sendMessage(taskMessage: URLSessionWebSocketTask.Message.string(string))
    }

    func sendMessage(data: Data) {
        Log.debug("[SignalingClient::sendMessage] data : \(data)")
        _sendMessage(taskMessage: URLSessionWebSocketTask.Message.data(data))
    }

    private func _sendMessage(taskMessage: URLSessionWebSocketTask.Message) {
        socket?.send(taskMessage) { error in
            guard let error = error else {
                return
            }
            Log.debug("[SignalingClient::_sendMessage] error: \(error)")
        }
    }

    private func receive() {
        let workItem = DispatchWorkItem{ [weak self] in
            self?.socket?.receive(completionHandler: { result in
                switch result {
                case .success(let message):
                    switch message {
                    case .data(let data):
                        self?.delegate?.webSocketReceviedData(didReceiveData: data)
                    case .string(let strMessgae):
                        self?.delegate?.webSocketReceviedString(didReceiveStr: strMessgae)
                    default:
                            break
                    }
                case .failure(let error):
                    Log.debug("[SignalingClient::_sendMessage] Error received \(error)")
            }
            self?.receive()
            })
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 1 , execute: workItem)
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        self.delegate?.webSocketDidConnect(session, webSocketTask: webSocketTask, didOpenWithProtocol: `protocol`)
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.delegate?.webSocketDidDisconnect(session, webSocketTask: webSocketTask, didCloseWith: closeCode, reason: reason)
        self.socket = nil
    }
}

extension SignalingClient: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        if challenge.previousFailureCount > 0 {
            completionHandler(.cancelAuthenticationChallenge, nil)
        } else if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            print("unknown state. error: \(String(describing: challenge.error))")
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
