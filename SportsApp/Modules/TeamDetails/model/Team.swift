//
//  Team.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 22/05/2024.
//

import Foundation

//class TeamsResponse: Codable {
//    let result: [Team]
//}
//
//class Team: Codable {
//    let teamKey: Int
//    let teamName: String
//    let teamLogo: String
//    let players: [Player]
//    
//    enum CodingKeys: String, CodingKey {
//        case teamKey = "team_key"
//        case teamName = "team_name"
//        case teamLogo = "team_logo"
//        case players = "players"
//    }
//    init(teamKey: Int, teamName: String, teamLogo: String, players: [Player]) {
//        self.teamKey = teamKey
//        self.teamName = teamName
//        self.teamLogo = teamLogo
//        self.players = players
//    }
//}
//
//class Player: Codable {
//    let playerKey: Int
//    let playerImage: String
//    let playerName: String
//    let playerNumber: String
//    
//    enum CodingKeys: String, CodingKey {
//        case playerKey = "player_key"
//        case playerImage = "player_image"
//        case playerName = "player_name"
//        case playerNumber = "player_number"
//    }
//}

//class TeamsResponse: Codable {
//    let result: [Team]
//}
//
//class Team: Codable {
//    let team_key: Int
//    let team_name: String
//    let team_logo: String
//    let players: [Player]
//    let coaches: [Coach]
//    
//    enum CodingKeys: String, CodingKey {
//        case team_key = "team_key"
//        case team_name = "team_name"
//        case team_logo = "team_logo"
//        case players = "players"
//        case coaches = "coaches"
//    }
//    
//    init(teamKey: Int, teamName: String, teamLogo: String, players: [Player], coaches: [Coach]) {
//        self.team_key = teamKey
//        self.team_name = teamName
//        self.team_logo = teamLogo
//        self.players = players
//        self.coaches = coaches
//    }
//}
//
//class Player: Codable {
//    let player_key: Int
//    let player_image: String
//    let player_name: String
//    let player_number: String
//    
//    enum CodingKeys: String, CodingKey {
//        case player_key = "player_key"
//        case player_image = "player_image"
//        case player_name = "player_name"
//        case player_number = "player_number"
//    }
//    
//    init(playerKey: Int, playerImage: String, playerName: String, playerNumber: String) {
//        self.player_key = playerKey
//        self.player_image = playerImage
//        self.player_name = playerName
//        self.player_number = playerNumber
//    }
//}
//
//class Coach: Codable {
//    let coach_name: String
//    let coach_country: String?
//    let coach_age: Int?
//    
//    enum CodingKeys: String, CodingKey {
//        case coach_name = "coach_name"
//        case coach_country = "coach_country"
//        case coach_age = "coach_age"
//    }
//    
//    init(coach_name: String, coach_country: String?, coach_age: Int?) {
//        self.coach_name = coach_name
//        self.coach_country = coach_country
//        self.coach_age = coach_age
//    }
//}


class TeamsResponse: Codable {
    var result: [Team]
}

class Team: Codable {
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]?
    var coaches: [Coach]?
    
    enum CodingKeys: String, CodingKey {
        case team_key = "team_key"
        case team_name = "team_name"
        case team_logo = "team_logo"
        case players = "players"
        case coaches = "coaches"
    }
    
    init(team_key: Int? = nil, team_name: String? = nil, team_logo: String? = nil, players: [Player]? = nil, coaches: [Coach]? = nil) {
        self.team_key = team_key
        self.team_name = team_name
        self.team_logo = team_logo
        self.players = players
        self.coaches = coaches
    }
}

class Player: Codable {
    var player_key: Int?
    var player_image: String?
    var player_name: String?
    var player_number: String?
    
    enum CodingKeys: String, CodingKey {
        case player_key = "player_key"
        case player_image = "player_image"
        case player_name = "player_name"
        case player_number = "player_number"
    }
    
    init(player_key: Int? = nil, player_image: String? = nil, player_name: String? = nil, player_number: String? = nil) {
        self.player_key = player_key
        self.player_image = player_image
        self.player_name = player_name
        self.player_number = player_number
    }
}

class Coach: Codable {
    var coach_name: String?
    var coach_country: String?
    var coach_age: Int?
    
    enum CodingKeys: String, CodingKey {
        case coach_name = "coach_name"
        case coach_country = "coach_country"
        case coach_age = "coach_age"
    }
    
    init(coach_name: String? = nil, coach_country: String? = nil, coach_age: Int? = nil) {
        self.coach_name = coach_name
        self.coach_country = coach_country
        self.coach_age = coach_age
    }
}


