//
//  GroupsResponse.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import Foundation

// MARK: - Groups
struct GroupsResponse: Codable {
    let success: Bool
    let grouped: Grouped
}

// MARK: - Grouped
struct Grouped: Codable {
    let a, b, c, d: [A]

    enum CodingKeys: String, CodingKey {
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
    }
}

// MARK: - A
struct A: Codable {
    let id: String
    let points, goals, matches, wins: Int
    let draws, loses, goalsReceived, goalsDifference: Int
    let groupID: String
    let nationalTeamID: NationalTeamID
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case points, goals, matches, wins, draws, loses
        case goalsReceived = "goals_received"
        case goalsDifference = "goals_difference"
        case groupID = "group_id"
        case nationalTeamID = "national_team_id"
        case v = "__v"
    }
}

// MARK: - NationalTeamID
struct NationalTeamID: Codable {
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
