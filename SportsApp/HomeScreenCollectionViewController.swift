//
//  HomeScreenCollectionViewController.swift
//  SportsApp
//
//  Created by Mohamed Kotb Saied Kotb on 16/05/2024.
//

import UIKit
class Sport{
    var name: String?
    var image: UIImage?
    
    init(name: String? = nil, image: UIImage? = nil) {
        self.name = name
        self.image = image
    }
}


let footballImage = UIImage(named: "football.jpeg")!
let basketballImage = UIImage(named: "football.jpeg")!
let tennisImage = UIImage(named: "football.jpeg")!
let cricketImage = UIImage(named: "football.jpeg")!

let football = Sport(name: "Football", image: footballImage)
let basketball = Sport(name: "Basketball", image: basketballImage)
let tennis = Sport(name: "Tennis", image: tennisImage)
let cricket = Sport(name: "Cricket", image: cricketImage)

class HomeScreenCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{


    let sports: [Sport] = [football, basketball, tennis, cricket]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
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
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeScreenCell
        cell.sportName.text = sports[indexPath.row].name
       // cell.sportImage.image = UIImage(named: "football")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.4, height: view.frame.width / 2)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesViewControler = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "leaguesVC") as! LeaguesTableViewController
        
        leaguesViewControler.sport = sports[indexPath.row].name ?? ""
        present(leaguesViewControler, animated: true, completion: nil)
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
