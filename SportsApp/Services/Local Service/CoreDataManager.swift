//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 20/05/2024.
//

import Foundation
import CoreData



class CoreDataHelper {
    static let shared = CoreDataHelper()
    let appDelegate: AppDelegate?
    let context : NSManagedObjectContext?
    private init() {
        appDelegate = Utility.appDelegete
        context = appDelegate?.persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportsApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    
    func saveLeague(league:FavoriteLeague) {
        
        guard let context = context else {return}
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteItem", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(league.league_key, forKey: "id")
        newEntity.setValue(league.league_name, forKey: "title")
        newEntity.setValue(league.league_logo, forKey: "image")
        newEntity.setValue(league.sport_name, forKey: "sport_name")
        do{
            try context.save()
            print("saved")
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteLeague(league:FavoriteLeague) {
        guard let context = context else {return}

        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavouriteItem")
        request.predicate = NSPredicate(format: "id == %d", league.league_key ?? -1)
        
        do {
            let results = try context.fetch(request)
            for object in results {
                context.delete(object as! NSManagedObject)
            }
            try context.save()
            print("League deleted from Core Data")
        } catch {
            print("Error deleting league from Core Data: \(error.localizedDescription)")
        }
    }
   
    
    func fetchSavedLeagues() -> [FavoriteLeague] {

        var savedLeagues: [FavoriteLeague] = []
        guard let context = context else {return savedLeagues}

        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "FavouriteItem")
        
        do {

            let fetchedEntities = try context.fetch(fetchRequest)
            for entity in fetchedEntities {
                if let id = entity.value(forKey: "id") as? Int,
                   let title = entity.value(forKey: "title") as? String,
                   let image = entity.value(forKey: "image") as? String,
                   let sport_name = entity.value(forKey: "sport_name") as? String{
                    let cashedLeague = FavoriteLeague(league_key: id, league_name: title, league_logo: image, sport_name: sport_name)
                    savedLeagues.append(cashedLeague)
                }
            }
        } catch {
            print("Error fetching saved leagues: \(error)")
        }
        
        return savedLeagues
    }
    func deleteAllLeagues() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteItem")
        
        do {
            guard let context = context else {return}

            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object as! NSManagedObject)
            }
            try context.save()
            print("All leagues deleted from Core Data")
        } catch {
            print("Error deleting all leagues from Core Data: \(error.localizedDescription)")
        }
    }

    func isLeagueFavorited(league: FavoriteLeague) -> Bool {
        guard let context = context else {return false}

        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavouriteItem")
        request.predicate = NSPredicate(format: "title == %@", league.league_name ?? "no data")
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if league is favorited: \(error.localizedDescription)")
            return false
        }
    }
    
}
