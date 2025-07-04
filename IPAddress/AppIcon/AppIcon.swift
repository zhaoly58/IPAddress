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
        ("默认图标", nil),                 // 主图标用 nil
        ("红色图标", "AppIcon 1"),
        ("蓝色图标", "AppIcon 2")
    ]
    
    var body: some View {
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
        let fallback = UIImage(systemName: "app")!
        
        // 用于预览的图标建议取 120x120 或 60x60 大小图
        let previewName = name ?? "AppIcon"
        let imageNames = [
            "\(previewName)_60",  // 你也可以用 "60.png" 之类的命名
            "\(previewName)_120",
            previewName
        ]
        
        for imageName in imageNames {
            if let img = UIImage(named: imageName) {
                return img
            }
        }
        
        return fallback
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
