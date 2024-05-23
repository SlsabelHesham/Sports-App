//
//  LeaguesDetailsViewModel.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 23/05/2024.
//

import Foundation

class LeagueDetailsViewModel{
    var bindResultToLeaguesDetailsViewController : (()->()) = {}
    var events : [Event]?{
        didSet{
            bindResultToLeaguesDetailsViewController()
        }
    }
    var latestResults : [Event]?{
        didSet{
            bindResultToLeaguesDetailsViewController()
        }
    }
    var teams: [Team]?{
        didSet {
            bindResultToLeaguesDetailsViewController()
        }
    }

    func getLeagueUpcomingEvents(sport: String){
        getUpcomingEventsFromNetwork(sport: sport) { [weak self] events in
            self?.events = events?.result
        }
    }
    func getLeagueLatesResults(sport: String){
        getLatestResultsFromNetwork(sport: sport) { [weak self] events in
            self?.latestResults = events?.result
        }
    }
    
    func getTeamsResults(sport: String , leagueId: Int){
        getTeamDetailsFromApi(sport: sport, leagueId: leagueId){ [weak self] teamsResult in
            self?.teams = teamsResult?.result
        }
    }

}
