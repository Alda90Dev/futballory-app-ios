//
//  PlayersResponse.swift
//  Futballory
//
//  Created by Aldair Carrillo on 28/11/23.
//

import Foundation

// MARK: - PlayersResponse
struct PlayersResponse: Codable {
    let success: Bool
    let players: [Player]
}

// MARK: - Player
struct Player: Codable {
    let id, name, displayName, completeName: String
    let number: Int
    let birthPlace, birthDate: String
    let position: Position
    let codePosition: CodePosition
    let positionEn: PositionEn
    let codePositionEn: CodePositionEn
    let playerType: PlayerType
    let nationalTeamID: String
    let v: Int
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case displayName = "display_name"
        case completeName = "complete_name"
        case number
        case birthPlace = "birth_place"
        case birthDate = "birth_date"
        case position
        case codePosition = "code_position"
        case positionEn = "position_en"
        case codePositionEn = "code_position_en"
        case playerType = "player_type"
        case nationalTeamID = "national_team_id"
        case v = "__v"
        case image
    }
}

enum CodePosition: String, Codable {
    case def = "DEF"
    case del = "DEL"
    case dt = "DT"
    case med = "MED"
    case por = "POR"
}

enum CodePositionEn: String, Codable {
    case co = "CO"
    case df = "DF"
    case fw = "FW"
    case gk = "GK"
    case md = "MD"
}

enum PlayerType: String, Codable {
    case coach = "COACH"
    case player = "PLAYER"
}

enum Position: String, Codable {
    case defensa = "DEFENSA"
    case delantero = "DELANTERO"
    case directorTecnico = "DIRECTOR TECNICO"
    case medio = "MEDIO"
    case portero = "PORTERO"
}

enum PositionEn: String, Codable {
    case coach = "COACH"
    case defense = "DEFENSE"
    case forward = "FORWARD"
    case goalkeeper = "GOALKEEPER"
    case midfielder = "MIDFIELDER"
}
