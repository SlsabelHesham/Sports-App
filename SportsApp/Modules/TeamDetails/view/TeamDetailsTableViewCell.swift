//
//  TeamDetailsTableViewCell.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 22/05/2024.
//

import UIKit

class TeamDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLogo: UIImageView!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
