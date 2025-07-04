//
//  AppICon.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/07/04.
//
//import SwiftUI
//
//struct AppIconMain: View {
//    @AppStorage("SelectedIcon")   var activeAppIcon: String = "AppIcon"
//    
//    var body: some View {
//        NavigationStack{
//            Picker (selection: $activeAppIcon) {
//                let customIcons : [String] = ["AppIcon", "AppIcon 1", "AppIcon 2"]
//                
//                ForEach (customIcons, id: \.self){ icon in
//                    Text(icon)
//                        .tag(icon)
//                }
//            } label: {
//                
//            }
//            .navigationTitle("Change App Icon ")
//            
//        }
//        .onChange(of: activeAppIcon){ newValue in
//            UIApplication.shared.setAlternateIconName(newValue == "AppIcon" ? nil : newValue) // nil means original icon
//        }
//    }
//}

import SwiftUI

struct AppIconMain: View {
    @AppStorage("SelectedIcon") var activeAppIcon: String = "AppIcon"
    
    /// icon name 映射到 Assets 中的资源前缀
    let customIcons: [(displayName: String, assetName: String?)] = [
        ("Default icon", nil),                 // 主图标用 nil
        ("Black icon", "AppIcon 1"),
        ("Orange icon", "AppIcon 2")
    ]
    
    var body: some View {
        padding()
        
        NavigationStack {
            List {
                ForEach(customIcons, id: \.assetName) { item in
                    HStack {
                        Image(uiImage: iconPreviewImage(for: item.assetName))
                            .resizable()
                            .frame(width: 48, height: 48)
                            .cornerRadius(8)
                        
                        Text(item.displayName)
                        
                        Spacer()
                        
                        if activeAppIcon == (item.assetName ?? "AppIcon") {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        switchIcon(to: item.assetName)
                    }
                }
            }
            .navigationTitle("Change App Icon")
        }
    }
    
    /// 获取预览图（可自行替换成 Assets 中的缩略图）
    func iconPreviewImage(for name: String?) -> UIImage {
        let previewName = name ?? "AppIcon" // 主图标
        return UIImage(named: previewName) ?? UIImage(systemName: "app")!
    }
    
    func switchIcon(to name: String?) {
        let iconName = name == "AppIcon" || name == nil ? nil : name
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("⚠️ 切换失败: \(error.localizedDescription)")
            } else {
                activeAppIcon = name ?? "AppIcon"
                print("✅ 已切换到图标: \(name ?? "AppIcon")")
            }
        }
    }
}
