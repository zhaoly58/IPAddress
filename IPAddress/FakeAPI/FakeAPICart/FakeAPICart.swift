//
//  FakeAPICart.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//


import SwiftUI
import Foundation
import Combine
import Kingfisher



class CartViewModel: ObservableObject {
    @Published var carts: [FakeAPIModelCart] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCarts()
    }
    
    func fetchCarts() {
        guard let url = URL(string: fakeAPICartUrl) else {
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
            .decode(type: FakeAPICarts.self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.carts = $0
            }
            .store(in: &cancellables)
    }
}




struct CartListView: View {
    //@StateObject private var viewModel = CartViewModel()
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        //NavigationView {
        List(viewModel.carts) { cart in
            NavigationLink(destination: FakeAPICartsDetails(oneCart: cart)) {
                CartRowView(cart: cart)
            }
        }
        .onAppear {
            viewModel.fetchCarts()
        }
        //.navigationTitle("Products")
        
    }
}




struct CartRowView: View {
    let cart: FakeAPIModelCart
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text(cart.date)
                    .font(.headline)
                
                //                    Text(cart.userID)
                //                        .font(.headline)
                
                //                    Text("Rating: \(String(cart.rating.rate)) (\(cart.rating.count) reviews)")
                //                        .font(.subheadline)
            }
            
        }
        .padding()
    }
}


#Preview {
    CartListView()
        .environmentObject(CartViewModel())
}

