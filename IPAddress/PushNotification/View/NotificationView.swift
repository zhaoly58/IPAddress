//
//  NotificationView.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/07/25.
//

import SwiftUI

struct NotificationView: View {
    @StateObject private var viewModel = NotificationViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Button("请求通知权限") {
                viewModel.requestAuthorization()
            }

            Button("发送本地通知") {
                viewModel.sendLocalNotification()
            }
        }
        .navigationTitle("Push Notification")
        .padding()
    }
}
