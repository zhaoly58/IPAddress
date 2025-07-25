//
//  NotificationViewModel.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/07/25.
//

import Foundation
import UserNotifications

@MainActor
class NotificationViewModel: ObservableObject {
    
    /// 请求通知权限
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("✅ 通知权限已授予")
            } else {
                print("❌ 用户拒绝通知权限")
            }
        }
    }

    /// 发送本地通知
    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "测试通知"
        content.body = "这是一条本地推送通知"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ 通知添加失败: \(error.localizedDescription)")
            } else {
                print("✅ 通知已安排发送")
            }
        }
    }
}
