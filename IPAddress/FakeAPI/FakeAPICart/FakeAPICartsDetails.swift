//
//  FakeAPICartsDetails.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/21.
//

import SwiftUI
import Kingfisher

struct FakeAPICartsDetails: View {
    var oneCart: FakeAPIModelCart
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack(alignment: .leading) {
                
                Text(oneCart.date)
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text("Category: \(oneCart.userID)")
                    .padding(.bottom, 10)
                
                Text("Products: \(oneCart.products)")
                    .padding(.bottom, 10)
                
            }
            .padding()
        }
        //.navigationTitle(oneCart.userID)
    }
}
