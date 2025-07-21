//
//  SettingsViewMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/12.
//

import SwiftUI

struct SettingsViewMain: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading) {
                    
                    HStack(){
                        Image(systemName: "link.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Link("Source Code", destination: URL(string: "https://github.com/zhaoly58/IPAddress#")!)
                    }
                    
                    Divider()
                    
                    HStack(){
                        Image(systemName: "pencil.and.scribble")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Link("Contact", destination: URL(string: "mailto:jimmyzly88@gmail.com")!)
                    }
                    
                    Divider()
                    
                    HStack(){
                        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                        Text("v\(appVersion)")
                            .foregroundColor(.black)
                    }
                    
                    Divider()
                    
                }
                .padding(30)
            }
            .navigationTitle("Settings")
            
            BannerAdView()
                .frame(width: 320, height: 100)
        }
        
    }
}

#Preview {
    SettingsViewMain()
}
