//
//  AppICon.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/07/04.
//
import SwiftUI

struct AppIconMain: View {
    @AppStorage("SelectedIcon")   var activeAppIcon: String = "AppIcon"
    
    var body: some View {
        NavigationStack{
            Picker (selection: $activeAppIcon) {
                let customIcons : [String] = ["AppIcon", "AppIcon 1", "AppIcon 2"]
                
                ForEach (customIcons, id: \.self){ icon in
                    Text(icon)
                        .tag(icon)
                }
            } label: {
                
            }
            .navigationTitle("Change App Icon ")
            
        }
        .onChange(of: activeAppIcon){ newValue in
            UIApplication.shared.setAlternateIconName(newValue)
            
        }
    }
}
