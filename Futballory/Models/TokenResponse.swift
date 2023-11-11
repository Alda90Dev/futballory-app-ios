//
//  TokenResponse.swift
//  Futballory
//
//  Created by Aldair Carrillo on 08/11/23.
//

import Foundation

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let success: Bool
    let user: User
    let token: String
}

// MARK: - User
struct User: Codable {
    let name, email, uid: String
}
