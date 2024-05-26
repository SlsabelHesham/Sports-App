//
//  CoreDataHelperTests.swift
//  SportsAppTests
//
//  Created by Mohamed Kotb Saied Kotb on 26/05/2024.
//

import XCTest
import CoreData
@testable import SportsApp

class CoreDataHelperTests: XCTestCase {
    
    var coreDataHelper: CoreDataHelper!
    var managedObjectContext: NSManagedObjectContext!
    
    let league = FavoriteLeague(league_key: 1, league_name: "Kotb", league_logo: "logo.png", sport_name: "Soccer")
    
    let league1 = FavoriteLeague(league_key: 1, league_name: "Premier League", league_logo: "logo1.png", sport_name: "Soccer")
    
    let league2 = FavoriteLeague(league_key: 2, league_name: "La Liga", league_logo: "logo2.png", sport_name: "Soccer")
    
    var array : [FavoriteLeague] = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let container = NSPersistentContainer(name: "SportsApp")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        coreDataHelper = CoreDataHelper.shared
        coreDataHelper.persistentContainer = container
        managedObjectContext = container.viewContext
    }
    
    override func tearDownWithError() throws {
        coreDataHelper = nil
        managedObjectContext = nil
        try super.tearDownWithError()
    }
    

    func testSaveLeague() {
        coreDataHelper.deleteAllLeagues()
            let league = FavoriteLeague(league_key: 123, league_name: "Test League", league_logo: "https://example.com/logo.png", sport_name: "Football")
    
        coreDataHelper.saveLeague(league: league)
            let appDelegate = Utility.appDelegete
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteItem")
        fetchRequest.predicate = NSPredicate(format: "sport_name = %@", league.sport_name ?? "")
    
            var fetchedResults: [NSManagedObject] = []
           do {
               fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
            } catch {
               XCTFail("Failed to fetch results")
           }
            XCTAssertEqual(fetchedResults.count, 1)
           let savedLeague = fetchedResults.first
           XCTAssertEqual(savedLeague?.value(forKey: "id") as? Int, league.league_key)
            XCTAssertEqual(savedLeague?.value(forKey: "title") as? String, league.league_name)
           XCTAssertEqual(savedLeague?.value(forKey: "image") as? String, league.league_logo)
            XCTAssertEqual(savedLeague?.value(forKey: "sport_name") as? String, league.sport_name)
       }


    
    func testFetchSavedLeagues() throws {
        coreDataHelper.deleteAllLeagues()
        coreDataHelper.saveLeague(league: league1)
        coreDataHelper.saveLeague(league: league2)
    
        let savedLeagues = coreDataHelper.fetchSavedLeagues()
   
        XCTAssertTrue(savedLeagues.contains { $0.league_key == league1.league_key })
        XCTAssertTrue(savedLeagues.contains { $0.league_key == league2.league_key })
    }
    
    
    func testDeleteLeague() {
        coreDataHelper.deleteAllLeagues()
        let league = FavoriteLeague(league_key: 123, league_name: "Test League", league_logo: "https://example.com/logo.png", sport_name: "Football")
        coreDataHelper.saveLeague(league: league)
        
        let appDelegate = Utility.appDelegete
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteItem")
        fetchRequest.predicate = NSPredicate(format: "sport_name = %@", league.sport_name ?? "")
        var fetchedResults: [NSManagedObject] = []
        do {
            fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            XCTFail("Failed to fetch results")
        }

        XCTAssertEqual(fetchedResults.count, 1)
        coreDataHelper.deleteLeague(league: league)

        do {
            fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            XCTFail("Failed to fetch results")
        }

        XCTAssertEqual(fetchedResults.count, 0)
    }

    func testDeleteAllLeagues() throws {
        coreDataHelper.saveLeague(league: league)
        coreDataHelper.saveLeague(league: league1)
        coreDataHelper.saveLeague(league: league2)
        
        let context = coreDataHelper.persistentContainer.viewContext
        try context.save()
        
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteItem")
        var fetchedEntities = try context.fetch(fetchRequest)
        coreDataHelper.deleteAllLeagues()
        fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteItem")
        fetchedEntities = try context.fetch(fetchRequest)
        XCTAssertEqual(fetchedEntities.count, 0)
    }
    
    func testSaveDuplicateLeague() {
        coreDataHelper.deleteAllLeagues()
        let league = FavoriteLeague(league_key: 123, league_name: "Test League", league_logo: "https://example.com/logo.png", sport_name: "Football")
        
        coreDataHelper.saveLeague(league: league)
        coreDataHelper.saveLeague(league: league)
        let appDelegate = Utility.appDelegete
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteItem")
        fetchRequest.predicate = NSPredicate(format: "sport_name = %@", league.sport_name ?? "")
        
        var fetchedResults: [NSManagedObject] = []
        do {
            fetchedResults = try context.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            XCTFail("Failed to fetch results")
        }
        XCTAssertEqual(fetchedResults.count, 2)
    }

            
    func testFetchEmptyLeagues() {
        coreDataHelper.deleteAllLeagues()
        let savedLeagues = coreDataHelper.fetchSavedLeagues()
        XCTAssertTrue(savedLeagues.isEmpty)
    }
}





    
