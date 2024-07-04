//
//  User.swift
//  Platin
//
//  Created by Reham Khalil on 04/07/2024.
//

import Foundation

struct User: Codable {
    var id: Int?
    var available_ads: Int?
    var name: String?
    var token: String?
    var image: String?
    var about: String?
    var phoneNumber: String?
    let whatsappNumber: String?
    let isAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case available_ads = "available_ads"
        case token = "token"
        case image = "image"
        case about = "about"
        case phoneNumber = "phone_number"
        case whatsappNumber = "whatsapp_number"
        case isAdmin = "is_admin"
    }
}
