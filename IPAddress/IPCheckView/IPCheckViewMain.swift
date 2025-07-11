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
        }
    }
}

#Preview {
    IPCheckViewMain()
}
