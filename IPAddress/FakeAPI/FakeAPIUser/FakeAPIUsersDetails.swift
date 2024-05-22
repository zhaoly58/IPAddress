//
//  FakeAPIUsersDetails.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/21.
//

import SwiftUI
import Kingfisher

struct FakeAPIUsersDetails: View {
    var oneUser: FakeAPIModelUser
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Name: \(oneUser.name.firstname) \(oneUser.name.lastname)")
                Text("Email: \(oneUser.email)")
                Text("Phone: \(oneUser.phone)")
                Text("Address: \(oneUser.address.street), \(oneUser.address.city), \(oneUser.address.zipcode)")
                Text("Geolocation: Lat \(oneUser.address.geolocation.lat), Long \(oneUser.address.geolocation.long)")
            }
            .padding()
            
//            VStack{
//                MapView(coordinate: oneUser.)
//            }
        }
        .navigationTitle(oneUser.name.firstname)
    }
}

#Preview {
    FakeAPIUsersDetails(oneUser: FakeAPIModelUser(
        address: Address(geolocation: Geolocation(lat: "10.0", long: "10.0"), city: "City", street: "Street", number: 1, zipcode: "12345"),
        id: 1, email: "email@example.com", username: "username", password: "password",
        name: Name(firstname: "Firstname", lastname: "Lastname"), phone: "123-456-7890", v: 1))
}
