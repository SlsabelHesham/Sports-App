//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 21/05/2024.
//

import UIKit
import Reachability
private let reuseIdentifier = "Cell"

class SportsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    let sports: [Sport] = [football, basketball, tennis, cricket]
    var reachability: Reachability!

    override func viewWillAppear(_ animated: Bool) {
        reachability = try! Reachability()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let fakeLeague = FavoriteLeague(league_key: 1, league_name: "Kotb", league_logo: "football.jpeg",sport_name: "football")
        CoreDataHelper.shared.saveLeague(league: fakeLeague)
        
        let fakeLeague2 = FavoriteLeague(league_key: 1, league_name: "Kotb2", league_logo: "football.jpeg",sport_name: "football")
        CoreDataHelper.shared.saveLeague(league: fakeLeague2)
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeScreenCell

        cell.sportName.text = sports[indexPath.row].name
       // cell.sportImage.image = UIImage(named: "football")
        
       // let league = leagues[indexPath.item]
        
        //cell.sportName.text = league.league_name
        //cell.sportImage.image = UIImage(named: league.league_logo ?? "notSAved")
        cell.contentView.layer.borderWidth = 0.5
                cell.contentView.layer.borderColor = UIColor(named: "BackgroundColor")?.cgColor
                cell.contentView.layer.cornerRadius = 20
                cell.layer.cornerRadius = 20


        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width / 2.4, height: view.frame.width / 2)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.bounds.width*0.45), height: (collectionView.bounds.width*0.85))
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.1
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
        }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let padding: CGFloat = 40
//            let collectionViewSize = collectionView.frame.size.width - padding
//            let collectionViewHeight = collectionView.frame.size.height - padding
//            let cellHeight = collectionViewHeight / 2
//            let cellWidth = collectionViewSize / 2
//            return CGSize(width: cellWidth - padding, height: cellHeight)
//        }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isInternetAvailable(){
            let leaguesViewControler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaguesVC") as! LeaguesTableViewController
            
            leaguesViewControler.sport = sports[indexPath.row].name ?? ""
            present(leaguesViewControler, animated: true, completion: nil)
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
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

