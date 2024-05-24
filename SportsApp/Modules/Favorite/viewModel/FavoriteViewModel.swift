//
//  FavoriteViewModel.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 20/05/2024.
//

import Foundation

class FavoriteViewModel{
    var bindResultToFavoriteViewController : (()->()) = {}
    var leagues : [FavoriteLeague]?{
        didSet{
            bindResultToFavoriteViewController()
        }
    }
    func getSavedLeagues(){
        self.leagues =  CoreDataHelper.shared.fetchSavedLeagues()
    }
    
    func deleteLeague (league: FavoriteLeague){
        CoreDataHelper.shared.deleteLeague(league: league)
    }
}
