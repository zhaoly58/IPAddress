//
//  FakeAPIDataModel.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/20.
//

import Foundation

// MARK: - FakeAPIElement
struct FakeAPIProduct: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias FakeAPIProducts = [FakeAPIProduct]
