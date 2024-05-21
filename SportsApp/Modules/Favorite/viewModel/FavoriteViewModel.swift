//
//  FavoriteViewModel.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 20/05/2024.
//

import Foundation

class FavoriteViewModel{
    var bindResultToFavoriteViewController : (()->()) = {}
    var leagues : [League]?{
        didSet{
            bindResultToFavoriteViewController()
        }
    }
    func getSavedLeagues(){
        self.leagues =  CoreDataHelper.shared.fetchSavedLeagues()
    }
}
