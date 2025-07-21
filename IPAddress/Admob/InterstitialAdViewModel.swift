//
//  InterstitialAd.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/07/17.
//

//import GoogleMobileAds
//
//class InterstitialAd: NSObject, FullScreenContentDelegate, ObservableObject {
//
//        private var interstitial: InterstitialAd?
//        private let adUnitID = "ca-app-pub-3940256099942544/4411468910" // 官方测试插页广告
//        @Published var isAdReady = false
//
//        override init() {
//            super.init()
//            loadAd()
//        }
//
//        func loadAd() {
//            let request = Request()
//            GADInterstitialAd.load(with: adUnitID, request: request) { [weak self] ad, error in
//                if let error = error {
//                    print("❌ Interstitial failed to load: \(error.localizedDescription)")
//                    self?.isAdReady = false
//                    return
//                }
//                self?.interstitial = ad
//                self?.interstitial?.fullScreenContentDelegate = self
//                self?.isAdReady = true
//                print("✅ Interstitial ready")
//            }
//        }
//
//        func showAd(from root: UIViewController?) {
//            guard let ad = interstitial, let root = root else { return }
//            ad.present(fromRootViewController: root)
//        }
//
//        func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
//            print("👋 Interstitial dismissed")
//            self.isAdReady = false
//            loadAd() // 再次加载
//        }
//}


import GoogleMobileAds

class InterstitialViewModel: NSObject, FullScreenContentDelegate, ObservableObject {
    private var interstitialAd: InterstitialAd?
    
    func loadAd() async {
        do {
            interstitialAd = try await InterstitialAd.load(
                with: "ca-app-pub-3940256099942544/4411468910", request: Request())
            // [START set_the_delegate]
            interstitialAd?.fullScreenContentDelegate = self
            // [END set_the_delegate]
        } catch {
            print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
    // [END load_ad]
    
    // [START show_ad]
    func showAd() {
        guard let interstitialAd = interstitialAd else {
            return print("Ad wasn't ready.")
        }
        
        interstitialAd.present(from: nil)
    }
    // [END show_ad]
    
    // MARK: - GADFullScreenContentDelegate methods
    
    // [START ad_events]
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("\(#function) called")
        // Clear the interstitial ad.
        interstitialAd = nil
    }
    // [END ad_events]
}
