//
//  MVVMViewMain.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2025/5/24.
//

import SwiftUI

struct MVVMViewMain: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                userView()
            }
        }
    }
}

#Preview {
    MVVMViewMain()
}
