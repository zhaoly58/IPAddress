//
//  IPAddressApp.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/08.
//

import SwiftUI
import GoogleMobileAds

@main
struct IPAddressApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        MobileAds.shared.start(completionHandler: nil)
            // 设置测试设备（用控制台打印的设备 ID 替换）
        print("ads device ID: ")
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = ["YOUR_DEVICE_ID"]
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
