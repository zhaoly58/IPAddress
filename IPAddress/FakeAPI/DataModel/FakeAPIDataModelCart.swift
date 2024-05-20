//
//  FakeAPIDataModelCart.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/20.
//

import Foundation

// MARK: - FakeAPIElement
struct FakeAPIModelCart: Codable {
    let id, userID: Int
    let date: String
    let products: [Product]
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case date, products
        case v = "__v"
    }
}

// MARK: - Product
struct Product: Codable {
    let productID, quantity: Int

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}

//typealias FakeAPI = [FakeAPIModelCart]


