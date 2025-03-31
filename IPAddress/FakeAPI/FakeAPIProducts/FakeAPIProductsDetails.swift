//
//  FakeAPIProductsDetails.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/20.
//

import SwiftUI
import Kingfisher

struct FakeAPIProductsDetails: View {
    var oneProduct: FakeAPIProduct
    
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack(alignment: .leading) {
                KFImage(URL(string: oneProduct.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
                
                Text(oneProduct.title)
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text("Category: \(oneProduct.category)")
                    .padding(.bottom, 10)
                
                Text(String(format: "$%.2f", oneProduct.price))
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text("Rating: \(String(oneProduct.rating.rate)) (\(oneProduct.rating.count) reviews)")
                    .font(.headline)
                    .padding(.bottom, 10)
                
                Text("Description: \(oneProduct.description)")
                    .padding(.bottom, 10)
            }
            .padding()
        }
        .navigationTitle(oneProduct.title)
    }
}


