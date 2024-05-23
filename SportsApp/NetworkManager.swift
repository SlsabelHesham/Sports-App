//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 20/05/2024.
//

import Foundation
import Alamofire



func getDataFromNetwork(sport: String, handler: @escaping (LeagueResult?) -> Void){
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

func getUpcomingEventsFromNetwork(sport: String, handler: @escaping (EventResult?) -> Void){
    let url = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=207&from=2024-05-23&to=2025-05-23&APIkey=\(Constants.api_key)"
    
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


