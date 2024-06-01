//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 21/05/2024.
//

import UIKit
import Reachability
private let reuseIdentifier = "sportsCell"

class SportsCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sports: [Sport] = [football, basketball, tennis, cricket]
    var reachability: Reachability!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reachability = try! Reachability()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.tintColor = UIColor.black
        if let items = self.tabBarController?.tabBar.items, items.count >= 2 {
            items[1].image = UIImage(systemName: "heart")
            items[1].title = "Favourites"
        }
        
        if let collectionView = collectionView {
            collectionView.collectionViewLayout = UICollectionViewFlowLayout()
            collectionView.dataSource = self
            collectionView.delegate = self
        } else {
            print("Error: collectionView outlet is not connected")
        }
        
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeScreenCell
        
        cell.sportView.layer.cornerRadius = 20.0
        cell.sportName.text = sports[indexPath.row].name
        cell.sportImage.image = sports[indexPath.row].image
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.45, height: collectionView.frame.width * 0.40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.5, left: 1, bottom: 0.5, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isInternetAvailable() {
                let leaguesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaguesVC") as! LeaguesTableViewController
                
                leaguesViewController.sport = sports[indexPath.row].name ?? "football"
                leaguesViewController.modalPresentationStyle = .fullScreen
                
                present(leaguesViewController, animated: true, completion: nil)
            
        } else {
            showAlert()
        }
    }
    
    func isInternetAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
