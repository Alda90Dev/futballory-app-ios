//
//  NetworkEndpoints.swift
//  Futballory
//
//  Created by Aldair Carrillo on 07/11/23.
//

import Foundation

enum NetworkEndpoints {
    case getToken
    case getMatches(date: String)
    
    var path: NetworkRouter {
        switch self {
        case .getToken:
            return NetworkRouter(path: "auth/login-app", method: .post)
        case .getMatches(let date):
            return NetworkRouter(path: "match/\(date)", method: .get)
        }
    }
}
