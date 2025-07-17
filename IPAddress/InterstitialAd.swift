//
//  InterstitialAd.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/07/17.
//

//import GoogleMobileAds
//import SwiftUI
//
//import GoogleMobileAds
//
//class InterstitialAd: NSObject, FullScreenContentDelegate, ObservableObject {
//    private var interstitial: InterstitialAd?
//    private let adUnitID = "ca-app-pub-3940256099942544/4411468910" // 官方测试插页广告
//    @Published var isAdReady = false
//
//    override init() {
//        super.init()
//        loadAd()
//    }
//
//    func loadAd() {
//        let request = Request()
//        InterstitialAd.load
//    }
//
//    func showAd(from root: UIViewController?) {
//        guard let ad = interstitial, let root = root else { return }
//        ad.present(from: root)
//    }
//
//    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
//        print("👋 Interstitial dismissed")
//        self.isAdReady = false
//        loadAd() // 再次加载
//    }
//}
