//
//  GroupsResponse.swift
//  Futballory
//
//  Created by Aldair Carrillo on 16/11/23.
//

import Foundation

// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let success: Bool
    let groups: [Group]
}

// MARK: - Group
struct Group: Codable {
    let group: String
    let teams: [GroupTeam]
}

// MARK: - Team
struct GroupTeam: Codable {
    let id: String
    let points, goals, matches, wins: Int
    let draws, loses, goalsReceived, goalsDifference: Int
    let groupID: String
    let nationalTeamID: Team
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
