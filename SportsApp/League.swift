//
//  League.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 20/05/2024.
//

import Foundation

class LeagueResult: Codable{
    var result: [League]?
}

class League: Codable {
    var league_key: Int?
    var league_name: String?
    var league_logo: String?
    
    enum keyConvension: String, CodingKey{
        case league_key = "league_key"
        case league_name = "league_name"
        case league_logo = "league_logo"
    }
    init(league_key: Int,
         league_name: String,
         league_logo: String) {
           self.league_key = league_key
           self.league_name = league_name
           self.league_logo = league_logo
       }
}
