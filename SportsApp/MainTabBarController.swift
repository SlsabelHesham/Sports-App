//
//  MainTabBarController.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 01/06/2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let tabBarItems = tabBar.items {
            // تاب الصفحة الرئيسية
            let homeTabBarItem = tabBarItems[0]
            homeTabBarItem.title = "الصفحة الرئيسية"
            homeTabBarItem.image = UIImage(named: "home_icon")
            
            // تاب البحث
            let searchTabBarItem = tabBarItems[1]
            searchTabBarItem.title = "بحث"
            searchTabBarItem.image = UIImage(named: "search_icon")
            
        }
    }
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
