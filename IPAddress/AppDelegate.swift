//
//  AppDelegate.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/06/20.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

      if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
          print("Firebase config found at: \(path)")
      } else {
          print("❌ Firebase config not found!")
      }
      
    return true
  }
}
