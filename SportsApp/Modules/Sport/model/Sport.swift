//
//  Sport.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 21/05/2024.
//

import Foundation
import UIKit

class Sport{
    var name: String?
    var image: UIImage?
    
    init(name: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.image = image
    }
}


let footballImage = UIImage(named: "football.png")!
let basketballImage = UIImage(named: "basketball.png")!
let tennisImage = UIImage(named: "tennis.png")!
let cricketImage = UIImage(named: "cricket.png")!

let football = Sport(name: "Football", image: footballImage)
let basketball = Sport(name: "Basketball", image: basketballImage)
let tennis = Sport(name: "Tennis", image: tennisImage)
let cricket = Sport(name: "Cricket", image: cricketImage)
