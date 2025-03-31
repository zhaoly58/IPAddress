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
                VStack(alignment: .leading){
                    Text("Name")
                        .fontWeight(.semibold)
                    Text("\(oneUser.name.firstname) \(oneUser.name.lastname)")
                }
                
                VStack(alignment: .leading){
                    Text("Email")
                        .fontWeight(.semibold)
                    Link("\(oneUser.email)", destination: URL(string: "mailto:\(oneUser.email)")!)
                }
                
                
                VStack(alignment: .leading){
                    Text("Phone")
                        .fontWeight(.semibold)
                    Text(oneUser.phone)
                    
                }
                
                VStack(alignment: .leading){
                    Text("Address")
                        .fontWeight(.semibold)
                    Text("\(oneUser.address.street), \(oneUser.address.city), \(oneUser.address.zipcode)")
                }
                
                VStack(alignment: .leading){
                    Text("GPS")
                        .fontWeight(.semibold)
                    Text("\(oneUser.address.geolocation)")
                }
                
                
                //Text("Geolocation: Lat \(oneUser.address.geolocation.lat), Long \(oneUser.address.geolocation.long)")
                
                VStack{
                    MapView(coordinate: oneUser.address.geolocation.locationCoordinate)
                        .frame(width: 300, height: 300)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle(oneUser.name.firstname)
    }
}

#Preview {
    FakeAPIUsersDetails(oneUser: FakeAPIModelUser(
        address: Address(geolocation: Geolocation(lat: "110.0", long: "110.0"), city: "City", street: "Street", number: 1, zipcode: "12345"),
        id: 1, email: "email@example.com", username: "username", password: "password",
        name: Name(firstname: "Firstname", lastname: "Lastname"), phone: "123-456-7890", v: 1))
}
