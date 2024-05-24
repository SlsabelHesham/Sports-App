//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 21/05/2024.
//

import Foundation

class LeaguesViewModel{
    var bindResultToLeaguesViewController : (()->()) = {}
    var leagues : [League]?{
        didSet{
            bindResultToLeaguesViewController()
        }
    }
    /*func getLeagues(sport: String){
        getDataFromNetwork(sport: sport) { [weak self] leagues in
            self?.leagues = leagues?.result
        }
    }*/
    func getLeagues(sport: String) {
        let leagueRequest = LeagueRequest(sport: sport)
        getDataFromNetwork(request: leagueRequest) { [weak self] (result: LeagueResult?) in
            self?.leagues = result?.result
        }
    }
}
