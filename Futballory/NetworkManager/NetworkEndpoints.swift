//
//  NetworkEndpoints.swift
//  Futballory
//
//  Created by Aldair Carrillo on 07/11/23.
//

import Foundation

enum NetworkEndpoints {
    case getToken
    case getDates
    case getMatches(date: String)
    case getGroups
    case getTeams
    case getStadiums
    case getPlayers(team: String)
    
    var path: NetworkRouter {
        switch self {
        case .getToken:
            return NetworkRouter(path: "auth/login-app", method: .post)
        case .getDates:
            return NetworkRouter(path: "match", method: .get)
        case .getMatches(let date):
            return NetworkRouter(path: "match/\(date)", method: .get)
        case .getGroups:
            return NetworkRouter(path: "group", method: .get)
        case .getTeams:
            return NetworkRouter(path: "national_team", method: .get)
        case .getStadiums:
            return NetworkRouter(path: "stadium", method: .get)
        case .getPlayers(let team):
            return NetworkRouter(path: "player/\(team)", method: .get)
        }
    }
}
