//
//  TeamDetailsViewModel.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 22/05/2024.
//

import Foundation
class TeamDetailsViewModel{
    
    var bindResultToTeamDetailsViewController : (()->()) = {}
    var teams : [Team]?{
        didSet{
            bindResultToTeamDetailsViewController()
        }
    }
    
//    func getTeamsDetails(sport: String , teamId: Int){
//        getTeamDetailsFromApi(sport: sport, teamId: teamId) { [weak self] teams in
//            self?.teams = teams?.result
//        }
//    }
    
}

