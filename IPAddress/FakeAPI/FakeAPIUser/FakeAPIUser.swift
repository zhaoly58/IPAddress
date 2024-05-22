//
//  FakeAPIUser.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/13.
//

import SwiftUI
import MapKit
import Foundation
import Combine


class UserViewModel: ObservableObject {
    @Published var users: [FakeAPIModelUser] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        guard let url = URL(string: fakeAPIUsersUrl) else {
            print("Invalid URL") // Debug print
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .handleEvents(receiveOutput: { data in
//                        print("Received data: \(data)") // Debug print
//                        if let jsonString = String(data: data, encoding: .utf8) {
//                            print("JSON String: \(jsonString)") // Debug print
//                        }
                    })
                    .decode(type: [FakeAPIModelUser].self, decoder: JSONDecoder())
                    .replaceError(with: [])
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.users = $0
                        print("Fetched users: \($0)") // Debug print
                    }
                    .store(in: &cancellables)
    }
}




struct UserListView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
//        NavigationView {
            List(viewModel.users) { user in
                NavigationLink(destination: FakeAPIUsersDetails(oneUser: user)) {
                    UserRowView(user: user)
                }
            }
            //.navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
//        }
    }
}




struct UserRowView: View {
    let user: FakeAPIModelUser

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(user.name.firstname) \(user.name.lastname)")
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                    Text(user.phone)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack{
                    MapView(coordinate: user.address.geolocation.locationCoordinate)
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }
//                Spacer()
//                MapView(coordinate: user.address.geolocation.locationCoordinate)
//                    .frame(width: 100, height: 100)
//                    .cornerRadius(10)
            }
        }
        .padding()
    }
}



#Preview {
    UserListView()
}

