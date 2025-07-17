//
//  IPCheckViewMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//

import SwiftUI
import GoogleMobileAds
import UIKit

struct IPCheckViewMain: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                IPCheckTab()
            }
            .onAppear {
                let request = Request()
                print("🔥 Triggering ad load request...")
                // 加载广告后 SDK 会在 Xcode 控制台输出 testDeviceIdentifiers 建议
            }
            BannerAdView()
                .frame(width: 320, height: 50)
        }
    }
}

#Preview {
    IPCheckViewMain()
}
