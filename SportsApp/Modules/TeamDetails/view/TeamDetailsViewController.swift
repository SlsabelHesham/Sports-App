//
//  TeamDetails.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 22/05/2024.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    var sport: String = ""
    var teamId: Int = 0 
    
    var viewModel : TeamDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        viewModel = TeamDetailsViewModel()
        viewModel?.bindResultToTeamDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                //render
                self?.tableView.reloadData()
                self?.teamLogo.kf.setImage(with: URL(string: self?.viewModel?.teams?.first?.teamLogo ?? ""))
                self?.teamName.text = self?.viewModel?.teams?.first?.teamName ?? ""
                

               // self?.indicator.stopAnimating()
            }
            
        }
        viewModel?.getTeamsDetails(sport: sport, teamId: teamId)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.teams?.first?.players.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeamDetailsTableViewCell

        cell.playerName.text = viewModel?.teams?[indexPath.row].players[indexPath.row].playerName
        cell.playerNumber.text = viewModel?.teams?[indexPath.row].players[indexPath.row].playerNumber

        cell.playerLogo.kf.setImage(with: URL(string: viewModel?.teams?[indexPath.row].players[indexPath.row].playerImage ?? ""))


        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
