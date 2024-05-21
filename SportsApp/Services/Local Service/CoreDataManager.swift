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
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportsApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    
    func saveLeague(league:League) {
        let appDelegate = Utility.appDelegete
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteItem", in: context)
        
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(league.league_key, forKey: "id")
        newEntity.setValue(league.league_name, forKey: "title")
        newEntity.setValue(league.league_logo, forKey: "image")
        do{
            try context.save()
            print("saved")
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteLeague(league:League) {
        let appDelegate = Utility.appDelegete
        let context = appDelegate.persistentContainer.viewContext
        
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
   
    
    func fetchSavedLeagues() -> [League] {
        var savedLeagues: [League] = []
        let appDelegate = Utility.appDelegete
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "FavouriteItem")
        
        do {
            let fetchedEntities = try context.fetch(fetchRequest)
            for entity in fetchedEntities {
                if let id = entity.value(forKey: "id") as? Int,
                   let title = entity.value(forKey: "title") as? String,
                   let image = entity.value(forKey: "image") as? String {
                    let cashedLeague = League(league_key: id, league_name: title, league_logo: image)
                    savedLeagues.append(cashedLeague)
                }
            }
        } catch {
            print("Error fetching saved leagues: \(error)")
        }
        
        return savedLeagues
    }
}
