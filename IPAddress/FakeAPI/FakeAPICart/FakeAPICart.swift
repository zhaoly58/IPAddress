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
            .map { $0.data }
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

