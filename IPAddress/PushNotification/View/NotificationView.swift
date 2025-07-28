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
        NavigationStack{
            ScrollView{
                VStack(spacing: 20) {
                    Button("请求通知权限") {
                        viewModel.requestAuthorization()
                    }
                    .frame(width: UIScreen.main.bounds.width - 240, height: 30)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    
                    Button("发送本地通知") {
                        viewModel.sendLocalNotification()
                    }
                    .frame(width: UIScreen.main.bounds.width - 240, height: 30)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    }
                }
                .navigationTitle("Push Notification")
                .padding()
                
            }
        }
    }
}
