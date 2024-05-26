//
//  MockNetworkService.swift
//  SportsAppTests
//
//  Created by Mohamed Kotb Saied Kotb on 25/05/2024.
//

import Foundation
@testable import SportsApp

class MockNetworkService {
    var result = TeamsResponse()
    // true = error, false = no error
    var flag: Bool
    
    init(flag: Bool) {
        self.flag = flag
    }
    
    let fakeJSONObj: [String: Any] = [
        "result": [
            [
                "team_key": 79,
                "team_name": "Inter Milan",
                "team_logo": "https://apiv2.allsportsapi.com/logo/79_inter-milan.jpg",
                "players": [
                    [
                        "player_key": 2665071992,
                        "player_image": "https://apiv2.allsportsapi.com/logo/players/390_s-de-vrij.jpg",
                        "player_name": "S. de Vrij",
                        "player_number": "6",
                        "player_country": NSNull(),
                        "player_type": "Defenders",
                        "player_age": "32",
                        "player_match_played": "25",
                        "player_goals": "1",
                        "player_yellow_cards": "0",
                        "player_red_cards": "0",
                        "player_injured": "No",
                        "player_substitute_out": "1",
                        "player_substitutes_on_bench": "16",
                        "player_assists": "0",
                        "player_birthdate": "1992-02-05",
                        "player_is_captain": "",
                        "player_shots_total": "",
                        "player_goals_conceded": "",
                        "player_fouls_committed": "",
                        "player_tackles": "",
                        "player_blocks": "",
                        "player_crosses_total": "",
                        "player_interceptions": "",
                        "player_clearances": "",
                        "player_dispossesed": "",
                        "player_saves": "",
                        "player_inside_box_saves": "",
                        "player_duels_total": "",
                        "player_duels_won": "",
                        "player_dribble_attempts": "",
                        "player_dribble_succ": "",
                        "player_pen_comm": "",
                        "player_pen_won": "",
                        "player_pen_scored": "",
                        "player_pen_missed": "",
                        "player_passes": "",
                        "player_passes_accuracy": "",
                        "player_key_passes": "",
                        "player_woordworks": "",
                        "player_rating": ""
                    ]
                ]
            ]
        ]
    ]
}

extension MockNetworkService {
    enum ResponseWithError: Error {
        case responseError
    }
    
    func fetchData(completionHandler: @escaping (TeamsResponse?, Error?) -> Void) {
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
             result = try JSONDecoder().decode(TeamsResponse.self, from: data)
            
            if flag {
                completionHandler(nil, ResponseWithError.responseError)
            } else {
                completionHandler(result, nil)
            }
        } catch {
            completionHandler(nil, error)
        }
    }
}

//class MockNetworkService: NetworkService {
//    var fakeJSONObj: [String: Any] = [
//        "result": [
//            [
//                "team_key": 79,
//                "team_name": "Inter Milan",
//                "team_logo": "https://apiv2.allsportsapi.com/logo/79_inter-milan.jpg",
//                "players": [
//                    [
//                        "player_key": 2665071992,
//                        "player_image": "https://apiv2.allsportsapi.com/logo/players/390_s-de-vrij.jpg",
//                        "player_name": "S. de Vrij",
//                        "player_number": "6",
//                        "player_country": NSNull(),
//                        "player_type": "Defenders",
//                        "player_age": "32",
//                        "player_match_played": "25",
//                        "player_goals": "1",
//                        "player_yellow_cards": "0",
//                        "player_red_cards": "0",
//                        "player_injured": "No",
//                        "player_substitute_out": "1",
//                        "player_substitutes_on_bench": "16",
//                        "player_assists": "0",
//                        "player_birthdate": "1992-02-05",
//                        "player_is_captain": "",
//                        "player_shots_total": "",
//                        "player_goals_conceded": "",
//                        "player_fouls_committed": "",
//                        "player_tackles": "",
//                        "player_blocks": "",
//                        "player_crosses_total": "",
//                        "player_interceptions": "",
//                        "player_clearances": "",
//                        "player_dispossesed": "",
//                        "player_saves": "",
//                        "player_inside_box_saves": "",
//                        "player_duels_total": "",
//                        "player_duels_won": "",
//                        "player_dribble_attempts": "",
//                        "player_dribble_succ": "",
//                        "player_pen_comm": "",
//                        "player_pen_won": "",
//                        "player_pen_scored": "",
//                        "player_pen_missed": "",
//                        "player_passes": "",
//                        "player_passes_accuracy": "",
//                        "player_key_passes": "",
//                        "player_woordworks": "",
//                        "player_rating": ""
//                    ]
//                ]
//            ]
//        ]
//    ]
//    
//    func fetchData(url: String, completionHandler: @escaping (Data?, Error?) -> Void) {
//        do {
//            let data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
//            completionHandler(data, nil)
//        } catch {
//            completionHandler(nil, error)
//        }
//    }
//}
//
