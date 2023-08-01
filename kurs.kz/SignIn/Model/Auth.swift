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

struct SignInResponse: Decodable {
    let access_token: String?
    let refresh_token: String?
}
