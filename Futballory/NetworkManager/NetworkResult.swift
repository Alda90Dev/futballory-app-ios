//
//  NetworkResult.swift
//  Futballory
//
//  Created by Aldair Carrillo on 07/11/23.
//

import Foundation

enum NetworkResult<T> {
    case success(data: T)
    case failure(error: Error)
}

enum NetworkErrorType: LocalizedError {
    case parseUrlFail
    case invalidResponse
    case dataError
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object"
        case .invalidResponse:
            return "Invalid Response"
        case .dataError:
            return "Invalid Data"
        case .serverError:
            return "Internal Server Error"
        }
    }
}
