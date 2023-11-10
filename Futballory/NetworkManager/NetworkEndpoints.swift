//
//  NetworkEndpoints.swift
//  Futballory
//
//  Created by Aldair Carrillo on 07/11/23.
//

import Foundation

enum NetworkEndpoints {
    case getToken
    case getProduct(id: Int)
    
    var path: NetworkRouter {
        switch self {
        case .getToken:
            return NetworkRouter(path: "login-app", method: .post)
        case .getProduct(let id):
            return NetworkRouter(path: "/products/\(id)", method: .get)
        }
    }
}
