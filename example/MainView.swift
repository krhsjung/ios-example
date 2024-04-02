//
//  ContentView.swift
//  example
//
//  Created by Hee Seok Jung on 2/28/24.
//

import SwiftUI
import UIKit

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: URLSessionWebSocketTaskView()) {
                    ExampleButtionLabel(text: "WebSocket Button(URLSessionWebSocketTask)")
                }
                NavigationLink(destination: WebSocketView()) {
                    ExampleButtionLabel(text: "WebSocket Button(Starscream)")
                }
                NavigationLink(destination: StompView()) {
                    ExampleButtionLabel(text: "Stomp Button")
                }
            }.padding()
        }
    }
}

struct ExampleButtionLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(.black)
            .cornerRadius(15)
    }
}


#Preview {
    MainView()
}
