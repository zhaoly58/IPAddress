//
//  userView.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/5/24.
//

import SwiftUI

struct userView: View {
    @StateObject private var viewModel = MVVMUserViewModel()
    
    var body: some View {
        VStack{
            VStack{
                Text(viewModel.user.name)
                    .font(.title)
                    .padding(EdgeInsets(top: 300, leading: 0, bottom: 10, trailing: 0))
                
                Button("Renew User Name"){
                    viewModel.changeName()
                }
                .frame(width: UIScreen.main.bounds.width - 220, height: 30)
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 1)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                //            .overlay(
                //                RoundedRectangle(cornerRadius: 10)
                //                    .stroke(Color.red, lineWidth: 2)
                //            )
                
            }
            .padding(.bottom, 150)
            
            Spacer()
            
            BannerAdView()
                .frame(width: 320, height: 50)
        }
    }
    
}

//#Preview {
//    userView()
//}

//import SwiftUI
//
//
//struct userView: View {
//    @StateObject private var viewModel = MVVMUserViewModel()
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            VStack {
//                Spacer()
//                Text(viewModel.user.name)
//                    .font(.title)
//                    .padding(.bottom, 10)
//
//                Button("Renew User Name") {
//                    viewModel.changeName()
//                }
//                .frame(width: UIScreen.main.bounds.width - 220, height: 30)
//                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 1)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                Spacer()
//            }
//            .padding(.bottom, 70) // 给广告留空间
//
//            BannerAdView()
//                .frame(width: 320, height: 50)
//                .padding(.bottom, 10)
//        }
//        .ignoresSafeArea(edges: .bottom) // 广告贴近底部（可选）
//    }
//}
