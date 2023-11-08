//
//  NetworkEndpoints.swift
//  Futballory
//
//  Created by Aldair Carrillo on 07/11/23.
//

import Foundation

enum NetworkEndpoints {
    case getProducts
    case getProduct(id: Int)
    
    var path: NetworkRouter {
        switch self {
        case .getProducts:
            return NetworkRouter(path: "/products", method: .get)
        case .getProduct(let id):
            return NetworkRouter(path: "/products/\(id)", method: .get)
        }
    }
}
