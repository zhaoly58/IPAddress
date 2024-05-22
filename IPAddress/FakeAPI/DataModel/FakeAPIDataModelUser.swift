//
//  FakeAPIDataModelUser.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/21.
//

import Foundation
import CoreLocation

struct FakeAPIModelUser: Codable, Identifiable {
    let address: Address
    let id: Int
    let email, username, password: String
    let name: Name
    let phone: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case address, id, email, username, password, name, phone
        case v = "__v"
    }
}

struct Address: Codable {
    let geolocation: Geolocation
    let city, street: String
    let number: Int
    let zipcode: String
}

struct Geolocation: Codable {
    let lat, long: String
    
    var locationCoordinate: CLLocationCoordinate2D {
        guard let latitude = Double(lat), let longitude = Double(long) else {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Name: Codable {
    let firstname, lastname: String
}

typealias FakeAPIUsers = [FakeAPIModelUser]
