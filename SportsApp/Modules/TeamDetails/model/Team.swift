//
//  Team.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 22/05/2024.
//

import Foundation

struct TeamsResponse: Codable {
    let result: [Team]
}

struct Team: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
    init(teamKey: Int, teamName: String, teamLogo: String, players: [Player]) {
        self.teamKey = teamKey
        self.teamName = teamName
        self.teamLogo = teamLogo
        self.players = players
    }
}

struct Player: Codable {
    let playerKey: Int
    let playerImage: String
    let playerName: String
    let playerNumber: String
    
    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
    }
}

