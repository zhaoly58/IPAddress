//
//  ContentView.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/08.
//

import SwiftUI
import URLImage
import SwiftSVG


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
                
                
                // Settings tab
                SettingsViewMain()
                    .navigationTitle("Settings")
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
            //.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}





#Preview {
    ContentView()
}

