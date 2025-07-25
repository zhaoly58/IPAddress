//
//  ContentView.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/08.
//

import SwiftUI
import URLImage
import SwiftSVG
import FirebaseAnalytics



struct ContentView: View {
    
    var body: some View {
        NavigationView {
            TabView{
                // IP Check tab
                IPCheckViewMain()
                    .navigationTitle("IP Check")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("IP Check")
                    }
                
                
                // Ping tab
                FakeAPIViewMain()
                    .navigationTitle("Fake API")
                    .tabItem {
                        Image(systemName: "network")
                        Text("Fake API")
                    }
                
                
                
                
                AppIconMain()
                    .navigationTitle("App Icon")
                    .tabItem {
                        Image(systemName: "matter.logo")
                        Text("App Icon")
                    }
                
//                if #available(iOS 26.0, *) {
//                    AIViewMain()
//                        .navigationTitle("AI Foundation Models")
//                        .tabItem {
//                            Image(systemName: "brain.head.profile")
//                            Text("AI")
//                        }
//                } else {
//                    // Fallback on earlier versions
//                }
                
                NotificationView()
                    .navigationTitle("Push Notification")
                    .tabItem {
                        Image(systemName: "app.badge.fill")
                        Text("Push Notification")
                    }
                
                MVVMViewMain()
                    .navigationTitle("MVVM User Name")
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("MVVM")
                    }
                
                // Settings tab
                SettingsViewMain()
                    .navigationTitle("Settings")
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                
                
                //                Button("触发测试事件 viewed_situation") {
                //                    Analytics.logEvent("viewed_situation", parameters: ["source": "manual_test"])
                //                    print("📡 Logged event: viewed_situation")
                //                }
                //                .padding()
            }
            //.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}




#Preview {
    ContentView()
}

