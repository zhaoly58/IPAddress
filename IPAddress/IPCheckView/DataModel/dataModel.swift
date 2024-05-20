//
//  dataModel.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/08.
//

import Foundation

// MARK: - IPAddress
struct IPAddress: Codable {
    let ip, ipNumber: String
    let ipVersion: Int
//    var ipVersionAsString: String {
//        return String(ipVersion)
//    }
    let countryName, countryCode2, isp, responseCode: String
    let responseMessage: String

    enum CodingKeys: String, CodingKey {
        case ip
        case ipNumber = "ip_number"
        case ipVersion = "ip_version"
        case countryName = "country_name"
        case countryCode2 = "country_code2"
        case isp
        case responseCode = "response_code"
        case responseMessage = "response_message"
    }
}
