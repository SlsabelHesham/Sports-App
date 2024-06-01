//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 20/05/2024.
//

import UIKit
import Kingfisher
import Reachability
class LeaguesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //var leagues: [League]? = []
    var leaguesViewModel: LeaguesViewModel?
    var reachability: Reachability!

    var sport: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: LeaguesTableViewCell.identifire)
        

        leaguesViewModel = LeaguesViewModel()
        leaguesViewModel?.bindResultToLeaguesViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()

            }
            
        }
        leaguesViewModel?.getLeagues(sport: sport)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       /* getDataFromNetwork(sport: sport) { [weak self] leagues in
            self?.leagues = leagues?.result
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }*/

    }
    override func viewWillAppear(_ animated: Bool) {
        reachability = try! Reachability()
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesViewModel?.leagues?.count ?? 0
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaguesTableViewCell.identifire, for: indexPath) as! LeaguesTableViewCell

        cell.leagueName.text = leaguesViewModel?.leagues?[indexPath.row].league_name

        cell.leagueImage.kf.setImage(with: URL(string: leaguesViewModel?.leagues?[indexPath.row].league_logo ?? ""))
        
        cell.secondView.layer.cornerRadius = 25

        cell.leagueImage.layer.cornerRadius = 50
        
        cell.layoutMargins = UIEdgeInsets(top: 0.5, left: 1, bottom: 0.5, right: 1.5)
    
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isInternetAvailable(){
            let leaguesDetailsViewControler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeagueDetails") as! LeaguesDetailsViewController
            leaguesDetailsViewControler.sport = self.sport
            leaguesDetailsViewControler.leagueId = leaguesViewModel?.leagues?[indexPath.row].league_key
            leaguesDetailsViewControler.leagueName = leaguesViewModel?.leagues?[indexPath.row].league_name ?? "league name"
            leaguesDetailsViewControler.leagueLogo = leaguesViewModel?.leagues?[indexPath.row].league_logo ?? "football.jpeg"
            
            leaguesDetailsViewControler.modalPresentationStyle = .fullScreen
            present(leaguesDetailsViewControler, animated: true, completion: nil)
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
