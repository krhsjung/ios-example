//
//  ContentView.swift
//  example
//
//  Created by Hee Seok Jung on 2/28/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: WebSocketView()) {
                    Text("WebSocket Button")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(.black)
                        .cornerRadius(15)
                }
                NavigationLink(destination: StompView()) {
                    Text("Stomp Button")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(.black)
                        .cornerRadius(15)
                }
            }.padding()
        }
    }
}


#Preview {
    MainView()
}
