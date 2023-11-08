//
//  NetworkRouter.swift
//  Futballory
//
//  Created by Aldair Carrillo on 07/11/23.
//

import Foundation

struct NetworkRouter {
    let path: String
    let method: HTTPMethod
    
    private static let baseURLString = "https://fakestoreapi.com"
    
    enum HTTPMethod {
        case get
        case post
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            }
        }
    }
    
    func request() throws -> URLRequest {
        let urlString = "\(NetworkRouter.baseURLString)\(path)"
        
        guard let url = URL(string: urlString) else { throw NetworkErrorType.parseUrlFail }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
