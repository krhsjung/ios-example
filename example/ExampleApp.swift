//
//  exampleApp.swift
//  example
//
//  Created by Hee Seok Jung on 2/28/24.
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
//            Permission.camera.checkPermission()
//            Permission.microphone.checkPermission()
            MainView()
        }
    }
}
