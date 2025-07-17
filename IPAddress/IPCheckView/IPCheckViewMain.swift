//
//  IPCheckViewMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//

import SwiftUI

struct IPCheckViewMain: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                IPCheckTab()
            }
            BannerAdView()
                .frame(width: 320, height: 50)
        }
    }
}

#Preview {
    IPCheckViewMain()
}
