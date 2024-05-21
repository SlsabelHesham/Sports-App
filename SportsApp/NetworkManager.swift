//
//  NetworkManager.swift
//  Swift Day6 Network
//
//  Created by Slsabel Hesham on 14/05/2024.
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
