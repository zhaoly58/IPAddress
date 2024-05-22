//
//  FakeAPIProducts.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//

import SwiftUI
import Foundation
import Combine
import Kingfisher



class ProductViewModel: ObservableObject {
    @Published var products: [FakeAPIProduct] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        guard let url = URL(string: fakeAPIAllProductsUrl) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: FakeAPIProducts.self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.products = $0
            }
            .store(in: &cancellables)
    }
}




struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        //NavigationView {
            List(viewModel.products) { product in
                NavigationLink(destination: FakeAPIProductsDetails(oneProduct: product)) {
                    ProductRowView(product: product)
                }
            }
            //.navigationTitle("Products")
    }
}




struct ProductRowView: View {
    let product: FakeAPIProduct
    
    var body: some View {
            HStack {
                KFImage(URL(string: product.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.headline)
                    Text(String(format: "$%.2f", product.price))
                        .font(.subheadline)
                    
                    Text("Rating: \(String(product.rating.rate)) (\(product.rating.count) reviews)")
                        .font(.subheadline)
                }
                
            }
            .padding()
    }
}


#Preview {
    ProductListView()
}

