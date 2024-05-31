//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 20/05/2024.
//

import UIKit
import Reachability

class FavoriteTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //var leagues: [League] = []
    var favoriteViewModel : FavoriteViewModel?
    var reachability: Reachability!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        reachability = try! Reachability()
        print("kotbbbbbbbbb")
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: LeaguesTableViewCell.identifire)
        
        favoriteViewModel = FavoriteViewModel()
        //leagues = CoreDataHelper.shared.fetchSavedLeagues()
            favoriteViewModel?.bindResultToFavoriteViewController = { [weak self] in
                DispatchQueue.main.async {
                    //render
                    self?.tableView.reloadData()

                   // self?.indicator.stopAnimating()
                }
                
            }
        print()
    }
    override func viewWillAppear(_ animated: Bool) {
        favoriteViewModel?.getSavedLeagues()
        self.tableView.reloadData()
        reachability = try! Reachability()
    }
        
    

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteViewModel?.leagues?.count ?? 0
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesTableViewCell.identifire, for: indexPath) as! LeaguesTableViewCell

        print(favoriteViewModel?.leagues?.count ?? -5)
        cell.leagueName.text = favoriteViewModel?.leagues?[indexPath.row].league_name

        cell.leagueImage.kf.setImage(with: URL(string: favoriteViewModel?.leagues?[indexPath.row].league_logo ?? "football.jpeg"))
        print(favoriteViewModel?.leagues?[indexPath.row].sport_name ?? "oo")
        
       // cell.contentView.layer.borderWidth = 0.5
       // cell.contentView.layer.borderColor = UIColor.systemGray2.cgColor
       // cell.contentView.layer.cornerRadius = 16
        
        cell.secondView.layer.cornerRadius = 25

        cell.leagueImage.layer.cornerRadius = 50
        
         cell.layoutMargins = UIEdgeInsets(top: 0.5, left: 1, bottom: 0.5, right: 1.5)


        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 128
   }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                confirmDeleteItem(at: indexPath)
            }
        }

        private func confirmDeleteItem(at indexPath: IndexPath) {
            let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this League?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.deleteItem(at: indexPath)
            })
            present(alert, animated: true, completion: nil)
        }

        private func deleteItem(at indexPath: IndexPath) {
            let item = favoriteViewModel?.leagues?[indexPath.row] ?? FavoriteLeague(league_key: -1, league_name: "", league_logo: "",sport_name: "")
            favoriteViewModel?.deleteLeague(league: item)
            favoriteViewModel?.leagues?.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            if isInternetAvailable() {
                // Navigate to leagues details
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
