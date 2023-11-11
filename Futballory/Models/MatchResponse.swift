//
//  MatchResponse.swift
//  Futballory
//
//  Created by Aldair Carrillo on 09/11/23.
//

import Foundation

// MARK: - Welcome
struct MatchResponse: Codable {
    let success: Bool
    let matches: [Match]
}

// MARK: - Match
struct Match: Codable {
    let id, date: String
    let localTeam, guestTeam: Team
    let localScore, guestScore, localPenaltiesScore, guestPenaltiesScore: Int
    let winnerScore, loserScore: Int
    let stage, status: String
    let stadium: Stadium
    let v: Int
    let loser: String?
    let result: String
    let winner: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case date
        case localTeam = "local_team"
        case guestTeam = "guest_team"
        case localScore = "local_score"
        case guestScore = "guest_score"
        case localPenaltiesScore = "local_penalties_score"
        case guestPenaltiesScore = "guest_penalties_score"
        case winnerScore = "winner_score"
        case loserScore = "loser_score"
        case stage, status, stadium
        case v = "__v"
        case loser, result, winner
    }
}

// MARK: - Team
struct Team: Codable {
    let id, name, nameEn, code: String
    let continent, confederationID: String
    let v: Int
    let icon: String
    let flag: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case nameEn = "name_en"
        case code, continent
        case confederationID = "confederation_id"
        case v = "__v"
        case icon, flag
    }
}

// MARK: - Stadium
struct Stadium: Codable {
    let id, name, nameEn: String
    let capacity: Int
    let city: String
    let v: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case nameEn = "name_en"
        case capacity, city
        case v = "__v"
        case photo
    }
}
