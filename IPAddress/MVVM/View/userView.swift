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
        .padding()
    }
    
}

//#Preview {
//    userView()
//}
