//
//  SettingsViewMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/12.
//

import SwiftUI

struct SettingsViewMain: View {
    var body: some View {
        NavigationView {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading) {
                VStack(){
                    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                    Text("v\(appVersion)")
                        .foregroundColor(.black)
                }
                
                Divider()
            }
            .padding(30)
        }
    }
    }
}

#Preview {
    SettingsViewMain()
}
