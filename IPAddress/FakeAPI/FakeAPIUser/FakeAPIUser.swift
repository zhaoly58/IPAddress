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
            .tryMap { result -> Data in
                if let response = result.response as? HTTPURLResponse {
                    print("response.url = \(String(describing:response.url))")
                    //                    print("response.mimeType = \(String(describing: response.mimeType))")
                    //                    print("response.expectedContentLength = \(response.expectedContentLength)")
                    //                    print("response.textEncodingName = \(String(describing: response.textEncodingName))")
                    //                    print("response.suggestedFilename = \(String(describing: response.suggestedFilename ))")
                    
                    
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
            .decode(type: [FakeAPIModelUser].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.users = $0
                //print("Fetched users: \($0)") // Debug print
            }
            .store(in: &cancellables)
    }
}




struct UserListView: View {
    //@StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var viewModel: UserViewModel
    
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
        .environmentObject(UserViewModel())
}

