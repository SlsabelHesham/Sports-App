//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 20/05/2024.
//

import Foundation
import Alamofire
/*
func getDataFromNetworkkk(sport: String, handler: @escaping (LeagueResult?) -> Void){
    let url = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\(Constants.api_key)"
    

    AF.request(url).responseData { response in
        switch response.result {
        case .success(let data):
            do {
                let results = try JSONDecoder().decode(LeagueResult.self, from: data)
                handler(results)
            } catch {
                print("\(error.localizedDescription)")
            }
        case .failure(let error):
            print("\(error.localizedDescription)")
        }
    }
}


func getTeamDetailsFromApi(sport: String,leagueId :Int, handler: @escaping (TeamsResponse?) -> Void){
    let url = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?&met=Teams&APIkey=\(Constants.api_key)&leagueId=\(leagueId)"
    
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(TeamsResponse.self, from: data)
                    handler(results)
                } catch {
                    print("1")
                    print("\(error.localizedDescription)")
                }
            case .failure(let error):
                print("2")
                print("\(error.localizedDescription)")
            }
        }

    
}

func getUpcomingEventsFromNetwork(sport: String, handler: @escaping (EventResult?) -> Void){
    let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=207&from=2024-05-23&to=2025-05-23&APIkey=\(Constants.api_key)"
    
    AF.request(url).responseData { response in
        switch response.result {
        case .success(let data):
            do {
                let results = try JSONDecoder().decode(EventResult.self, from: data)
                handler(results)
            } catch {
                print("\(error.localizedDescription)")
            }
        case .failure(let error):
            print("\(error.localizedDescription)")
        }
    }
}

        
    

func getLatestResultsFromNetwork(sport: String, handler: @escaping (EventResult?) -> Void){
    let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=207&from=2023-05-23&to=2024-05-23&APIkey=\(Constants.api_key)"
    
    AF.request(url).responseData { response in
        switch response.result {
        case .success(let data):
            do {
                let results = try JSONDecoder().decode(EventResult.self, from: data)
                handler(results)
                print("ss")
            } catch {
                print("\(error.localizedDescription)")
                print("1")
            }
        case .failure(let error):
            print("\(error.localizedDescription)")
            print("2")

        }
    }
}
*/

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


func getDataFromNetwork<T: Decodable>(request: Request, handler: @escaping (T?) -> Void) {
    AF.request(request.url).responseData { response in
        switch response.result {
        case .success(let data):
            do {
                let result = try request.decode(data: data) as? T
                handler(result)
            } catch {
                print("\(error.localizedDescription)")
                handler(nil)
            }
        case .failure(let error):
            print("\(error.localizedDescription)")
            handler(nil)
        }
    }
}
