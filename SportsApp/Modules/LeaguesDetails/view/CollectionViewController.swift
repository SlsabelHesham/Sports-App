//
//  CollectionViewController.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 23/05/2024.
//

import UIKit
import Reachability

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var leaguesDetailsViewModel: LeagueDetailsViewModel?
    var reachability: Reachability!
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try! Reachability()
        self.collectionView.delegate = self

        // Set up the compositional layout
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                return self.UpcomingEventsSection()
            case 1:
                return self.LatestResultsSection()
            case 2 :
                return self.TeamsSection()
            default:
                return self.TeamsSection()
            }
        }

        collectionView.setCollectionViewLayout(layout, animated: true)

        leaguesDetailsViewModel = LeagueDetailsViewModel()
        leaguesDetailsViewModel?.bindResultToLeaguesDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.collectionView.reloadData()

            }
            
        }
        leaguesDetailsViewModel?.getLeagueUpcomingEvents(sport: "football")
        leaguesDetailsViewModel?.getLeagueLatesResults(sport: "football")
        leaguesDetailsViewModel?.getTeamsResults(sport: "football", leagueId: 152)
    }
    override func viewWillAppear(_ animated: Bool) {
        leaguesDetailsViewModel?.getTeamsResults(sport: "football", leagueId: 152)
    }
    func UpcomingEventsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9)
                                               , heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                       , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    func LatestResultsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9)
                                               , heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                       , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    func TeamsSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                      , bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                        , bottom: 10, trailing: 15)
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Header", alignment: .top)]
        
        return section
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
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            if let events = leaguesDetailsViewModel?.events, indexPath.row < events.count {
                let event = events[indexPath.row]
                cell.team1Name.text = event.event_home_team
                cell.team2Name.text = event.event_away_team
                cell.date.text = event.event_date
                cell.team1Img.kf.setImage(with: URL(string: event.home_team_logo ?? ""))
                cell.team2Img.kf.setImage(with: URL(string: event.away_team_logo ?? ""))
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultsCell", for: indexPath) as! LatestResultsCollectionViewCell
            if let results = leaguesDetailsViewModel?.latestResults, indexPath.row < results.count {
                let result = results[indexPath.row]
                cell.team1NameR.text = result.event_home_team
                cell.team2NameR.text = result.event_away_team
                cell.dateR.text = result.event_date
                cell.resultR.text = result.event_final_result
                cell.team1ImgR.kf.setImage(with: URL(string: result.home_team_logo ?? ""))
                cell.team2ImgR.kf.setImage(with: URL(string: result.away_team_logo ?? ""))
            }
            return cell

        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCollectionViewCell
            print(leaguesDetailsViewModel?.teams?.count)
            if let results = leaguesDetailsViewModel?.teams, indexPath.row < results.count {
                let result = results[indexPath.row]
                print(result.players?.count)
               
                
                cell.teamsLogo.kf.setImage(with: URL(string: result.team_logo ?? ""))
            }
            return cell
            
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return leaguesDetailsViewModel?.events?.count ?? 0
        case 1:
            return leaguesDetailsViewModel?.latestResults?.count ?? 0
        case 2:
            return leaguesDetailsViewModel?.teams?.count ?? 8
        default:
            return 0
        }
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
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the size for the header view
        return CGSize(width: collectionView.bounds.width, height: 50) // Adjust the height as needed
    }
    
   /* override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       // if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterHeaderView.headerIdentifier, for: indexPath) as! FilterHeaderView
            return headerView
        //} else {
       //     fatalError("Unexpected supplementary view kind: \(kind)")
        //}
    }
    */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section  == 2) {
            if isInternetAvailable(){
                let teamsViewControler = UIStoryboard(name: "TeamDetails", bundle: nil).instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
                
                teamsViewControler.team = leaguesDetailsViewModel?.teams?[indexPath.row] ?? Team()
                present(teamsViewControler, animated: true, completion: nil)
                
            } else {
                showAlert()
            }
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

/*
class FilterHeaderView: UICollectionReusableView {
    
    static let headerIdentifier = "FilterHeaderView"
    
    var leadingConstraints: NSLayoutConstraint?
    var trailingConstraints: NSLayoutConstraint?
    /*
     var isSticky: Bool? {
     didSet{
     guard let isSticky = isSticky else { return }
     if isSticky {
     divider.isHidden = false
     leadingConstraints?.constant = 17
     trailingConstraints?.constant = -17
     } else {
     divider.isHidden = true
     leadingConstraints?.constant = 2
     trailingConstraints?.constant = -2
     }
     }
     }
     */
    // Properties for header components
    // ...
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        // Add and configure header components
        // ...
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        // Set up constraints for header components
        // ...
    }
    
}

*/
