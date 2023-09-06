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
    let accessToken: String?
    let refreshToken: String?
    let user: UserInfo?
}

struct UserInfo: Codable {
    let id: Int?
    let name: String?
    let surname: String?
    let phone: String?
    let status: String?
    let role: String?
}
