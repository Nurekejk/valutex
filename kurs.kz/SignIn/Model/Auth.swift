//
//  Auth.swift
//  kurs.kz
//
//  Created by Акерке on 26.07.2023.
//

import Foundation

struct SignInRequest: Encodable {
    let username: String
    let password: String
}

struct SignInResponse: Codable {
    let access_token: String?
    let refresh_token: String?
    let user: UserInfo?
}

struct UserInfo: Codable {
    let id: Int?
    let name: String?
    let surname: String?
    let middleName: String?
    let phone: String?
    let status: String?
    let role: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case middleName = "middle_name"
        case phone
        case status
        case role
        }
}
