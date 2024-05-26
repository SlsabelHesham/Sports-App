//
//  FavoriteLeague.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 24/05/2024.
//

import Foundation
class FavoriteLeagueResult: Codable{
    var result: [FavoriteLeague]?
}

class FavoriteLeague: Codable {
    var league_key: Int?
    var league_name: String?
    var league_logo: String?
    var sport_name: String?
    
    enum keyConvension: String, CodingKey{
        case league_key = "league_key"
        case league_name = "league_name"
        case league_logo = "league_logo"
        case sport_name = "sport_name"
    }
    init(league_key: Int? = nil, league_name: String? = nil, league_logo: String? = nil, sport_name: String? = nil) {
        self.league_key = league_key
        self.league_name = league_name
        self.league_logo = league_logo
        self.sport_name = sport_name
    }
}
