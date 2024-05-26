//
//  Requests.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 26/05/2024.
//

import Foundation

protocol Request {
    var url: String { get }
    func decode(data: Data) throws -> Decodable
}

struct LeagueRequest: Request {
    let sport: String
    
    var url: String {
        return "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\(Constants.api_key)"
    }
    
    func decode(data: Data) throws -> Decodable {
        return try JSONDecoder().decode(LeagueResult.self, from: data)
    }
}

struct TeamRequest: Request {
    let sport: String
    let leagueId: Int
    
    var url: String {
        return "https://apiv2.allsportsapi.com/\(sport.lowercased())/?&met=Teams&APIkey=\(Constants.api_key)&leagueId=\(leagueId)"
    }
    
    func decode(data: Data) throws -> Decodable {
        return try JSONDecoder().decode(TeamsResponse.self, from: data)
    }
}

struct UpcomingEventsRequest: Request {
    let sport: String
    let leagueId: Int
    let fromDate: String
    let toDate: String
    
    var url: String {
        return "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(Constants.api_key)"
    }
    
    func decode(data: Data) throws -> Decodable {
        return try JSONDecoder().decode(EventResult.self, from: data)
    }
}

struct LatestResultsRequest: Request {
    let sport: String
    let leagueId: Int
    let fromDate: String
    let toDate: String
    
    var url: String {
        return "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Fixtures&leagueId=\(leagueId)&from=\(fromDate)&to=\(toDate)&APIkey=\(Constants.api_key)"
    }
    
    func decode(data: Data) throws -> Decodable {
        return try JSONDecoder().decode(EventResult.self, from: data)
    }
}

