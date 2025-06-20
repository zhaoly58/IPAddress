//
//  IPAddressApp.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/08.
//

import SwiftUI

@main
struct IPAddressApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
