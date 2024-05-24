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
    /*
     func getLeagueUpcomingEvents(sport: String){
     getUpcomingEventsFromNetwork(sport: sport) { [weak self] events in
     self?.events = events?.result
     }
     }
     */
    func getLeagueUpcomingEvents(sport: String, leagueId: Int, fromDate: String, toDate: String) {
        let upcomingEventsRequest = UpcomingEventsRequest(sport: sport, leagueId: leagueId, fromDate: fromDate, toDate: toDate)
        getDataFromNetwork(request: upcomingEventsRequest) { [weak self] (events: EventResult?) in
            self?.events = events?.result
        }
    }
    
    /*
     func getLeagueLatesResults(sport: String){
     getLatestResultsFromNetwork(sport: sport) { [weak self] events in
     self?.latestResults = events?.result
     }
     }
     */
    func getLeagueLatesResults(sport: String, leagueId: Int, fromDate: String, toDate: String) {
        let latestResultsRequest = LatestResultsRequest(sport: sport, leagueId: leagueId, fromDate: fromDate, toDate: toDate)
        getDataFromNetwork(request: latestResultsRequest) { [weak self] (latestResults: EventResult?) in
            self?.latestResults = latestResults?.result
        }
    }
    
    /*
     func getTeamsResults(sport: String , leagueId: Int){
     getTeamDetailsFromApi(sport: sport, leagueId: leagueId){ [weak self] teamsResult in
     self?.teams = teamsResult?.result
     }
     }
     */
    func getTeamsResults(sport: String, leagueId: Int) {
        let teamsRequest = TeamRequest(sport: sport, leagueId: leagueId)
        getDataFromNetwork(request: teamsRequest) { [weak self] (teams: TeamsResponse?) in
            self?.teams = teams?.result
        }
    }
}
