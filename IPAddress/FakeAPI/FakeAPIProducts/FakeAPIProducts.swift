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
            .tryMap { result -> Data in
                if let response = result.response as? HTTPURLResponse {
                    print("response.url = \(String(describing:response.url))")
                    //                                        print("response.mimeType = \(String(describing: response.mimeType))")
                    //                                        print("response.expectedContentLength = \(response.expectedContentLength)")
                    //                                        print("response.textEncodingName = \(String(describing: response.textEncodingName))")
                    //                                        print("response.suggestedFilename = \(String(describing: response.suggestedFilename ))")
                    
                    
                    // HTTPURLResponseのプロパティ
                    print("response.statusCode = \(response.statusCode)")
                    //print("response.statusCode localizedString=\(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
                    
                    for _ in response.allHeaderFields{
                        //print("response.allHeaderFields[\"\(item.key)\"] = \(item.value)")
                    }
                }
                return result.data
            }
            .handleEvents(receiveOutput: { data in
                // Debug print for received data
                if let jsonString = String(data: data, encoding: .utf8) {
                    //print("JSON String: \(jsonString)")
                }
            })
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
    //@StateObject private var viewModel = ProductViewModel()
    @EnvironmentObject var viewModel: ProductViewModel
    
    var body: some View {
        //NavigationView {
        List(viewModel.products) { product in
            NavigationLink(destination: FakeAPIProductsDetails(oneProduct: product)) {
                ProductRowView(product: product)
            }
        }
        .onAppear {
            viewModel.fetchProducts()
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
        .environmentObject(ProductViewModel())
}

