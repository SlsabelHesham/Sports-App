//
//  Event.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 23/05/2024.
//

import Foundation

class EventResult: Codable{
    var result: [Event]?
}

class Event: Codable {
    var event_key: Int?
    var event_date: String?
    
    var event_home_team: String?
    var home_team_key: Int?
    
    var event_away_team: String?
    var away_team_key: Int?
    
    var home_team_logo: String?
    var away_team_logo: String?
    
    var event_final_result: String?
    
    enum keyConvension: String, CodingKey{
        case event_key = "event_key"
        case event_date = "event_date"
        case event_home_team = "event_home_team"
        
        
        case home_team_key = "home_team_key"
        case event_away_team = "event_away_team"
        case away_team_key = "away_team_key"
        
        
        case home_team_logo = "home_team_logo"
        case away_team_logo = "away_team_logo"
        
        case event_final_result = "event_final_result"
    }
    init(event_key: Int? = nil, event_date: String? = nil, event_home_team: String? = nil, home_team_key: Int? = nil, event_away_team: String? = nil, away_team_key: Int? = nil, home_team_logo: String? = nil, away_team_logo: String? = nil, event_final_result: String? = nil) {
        self.event_key = event_key
        self.event_date = event_date
        self.event_home_team = event_home_team
        self.home_team_key = home_team_key
        self.event_away_team = event_away_team
        self.away_team_key = away_team_key
        self.home_team_logo = home_team_logo
        self.away_team_logo = away_team_logo
        self.event_final_result = event_final_result
    }
}
