import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import FirebaseInAppMessaging
import FirebaseInstallations

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 1. 初始化 Firebase
        FirebaseApp.configure()
        
        // 2. 检查 GoogleService-Info.plist 是否成功加载
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
            print("✅ Firebase config found at: \(path)")
        } else {
            print("❌ Firebase config not found!")
        }
        
        // 3. 启用 Analytics（必须）
        Analytics.logEvent(AnalyticsEventAppOpen, parameters: nil)
        
        // 4. 启用 Firebase In-App Messaging 设置
//        FirebaseInAppMessaging.inAppMessaging().messageDisplaySuppressed = false
//        FirebaseInAppMessaging.inAppMessaging().automaticDataCollectionEnabled = true
        InAppMessaging.inAppMessaging().messageDisplaySuppressed = false
        InAppMessaging.inAppMessaging().automaticDataCollectionEnabled = true
        
        InAppMessaging.inAppMessaging().delegate = self
        
        // 5. 打印 FID（用于添加测试设备）
        Installations.installations().installationID { fid, error in
            if let fid = fid {
                print("🔥 Firebase Installation ID (FID): \(fid)")
            } else if let error = error {
                print("❌ Failed to get FID: \(error.localizedDescription)")
            }
        }
        
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("Received URL: \(url.absoluteString)")
        return true
    }
}


extension AppDelegate: InAppMessagingDisplayDelegate {
    func messageDismissed(_ inAppMessage: InAppMessagingDisplayMessage, dismissType: InAppMessagingDismissType) {
        print("🛑 FIAM dismissed: \(dismissType.rawValue)")
    }

    func messageClicked(_ inAppMessage: InAppMessagingDisplayMessage) {
        print("✅ FIAM clicked")
    }

    func impressionDetected(for inAppMessage: InAppMessagingDisplayMessage) {
        print("👁 FIAM impression detected")
    }

    func displayError(for inAppMessage: InAppMessagingDisplayMessage, error: Error) {
        print("❌ FIAM display error: \(error.localizedDescription)")
    }
}
