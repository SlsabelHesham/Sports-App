//
//  CollectionViewController.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 23/05/2024.
//

import UIKit
import Reachability

class LeaguesDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var sport: String?
    var leagueId: Int?
    var leaguesDetailsViewModel: LeagueDetailsViewModel?
    var reachability: Reachability!
    
    var league : FavoriteLeague!
    var leagueName:String = ""
    var leagueLogo:String = ""

    
    @IBAction func favBtn(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected{
            self.leaguesDetailsViewModel?.insertFavouriteLeague(league: league)
        }else{
            self.leaguesDetailsViewModel?.deleteFavLeague(league: league)
        }
    }
    @IBOutlet weak var leaguesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var favBtn: UIButton!
    
    func isLeagueFavorited(league: FavoriteLeague) -> Bool {
        return CoreDataHelper.shared.isLeagueFavorited(league: league)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try! Reachability()
        self.leaguesCollectionView.delegate = self
        self.leaguesCollectionView.dataSource = self
       
        league = FavoriteLeague(league_key: leagueId, league_name: leagueName, league_logo: leagueLogo, sport_name: sport)

        
        favBtn.isSelected = self.isLeagueFavorited(league: league)
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favBtn.setImage(UIImage(systemName: "heart"), for: .normal)

        
        leaguesCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
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

        leaguesCollectionView.setCollectionViewLayout(layout, animated: true)

        leaguesDetailsViewModel = LeagueDetailsViewModel()
        leaguesDetailsViewModel?.bindResultToLeaguesDetailsViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.leaguesCollectionView.reloadData()
            }
        }
        let dates = getDates()
        leaguesDetailsViewModel?.getLeagueUpcomingEvents(sport: sport ?? "football", leagueId: leagueId ?? 0, fromDate: dates.currentDate, toDate: dates.nextYearDate)
        leaguesDetailsViewModel?.getLeagueLatesResults(sport: sport ?? "football", leagueId: leagueId ?? 0, fromDate: dates.lastYearDate, toDate: dates.currentDate)
        leaguesDetailsViewModel?.getTeamsResults(sport: sport ?? "football", leagueId: leagueId ?? 0)
    }
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! CustomHeaderView
            
            switch indexPath.section {
            case 0:
                header.titleLabel.text = "Upcoming Events"
            case 1:
                header.titleLabel.text = "Latest Results"
            case 2:
                header.titleLabel.text = "Teams"
            default:
                header.titleLabel.text = "Section"
            }
            
            return header
        }
        return UICollectionReusableView()
    }

    func UpcomingEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            let centerX = offset.x + environment.container.contentSize.width / 2.0
            items.forEach { item in
                let distanceFromCenter = abs(item.frame.midX - centerX)
                let scale: CGFloat = distanceFromCenter < 50 ? 1.2 : 1.0
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
                
            }
        }
        
        return section
    }

    func LatestResultsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .none

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }


    func TeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
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
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            print("test")
            if let events = leaguesDetailsViewModel?.events, indexPath.row < events.count {
                let event = events[indexPath.row]

                if(events.count != 0){
                    cell.noUpcoming.isHidden = true
                print("jjj\(event.event_second_player)")
                if  sport == "Tennis"{
                    print("if")
                    cell.team1Name.text = event.event_first_player
                    cell.team2Name.text = event.event_second_player
                    print(event.event_second_player ?? "false")
                    print(event.event_second_player ?? "false")
                    cell.date.text = event.event_date
                    cell.team1Img.kf.setImage(with: URL(string: event.event_first_player_logo ?? ""),
                        placeholder: UIImage(named: "player")
                    )
                    cell.team2Img.kf.setImage(with: URL(string: event.event_second_player_logo ?? ""),placeholder: UIImage(named: "player"))
                } else{
                    cell.team1Name.text = event.event_home_team
                    cell.team2Name.text = event.event_away_team
                    cell.date.text = event.event_date
                    cell.team1Img.kf.setImage(with: URL(string: event.home_team_logo ?? ""))
                    cell.team2Img.kf.setImage(with: URL(string: event.away_team_logo ?? ""))
                }
                    
                }else{
                    cell.noUpcoming.isHidden = false
                }

            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultsCell", for: indexPath) as! LatestResultsCollectionViewCell
            if let results = leaguesDetailsViewModel?.latestResults, indexPath.row < results.count {
                let result = results[indexPath.row]

                if self.sport == "Tennis"{
                    print("if")
                    cell.team1NameR.text = result.event_first_player
                    cell.team2NameR.text = result.event_second_player
                    print(result.event_second_player ?? "false")
                    print(result.event_second_player ?? "false")
                    cell.dateR.text = result.event_date
                    cell.resultR.text = result.event_final_result
                    cell.team1ImgR.kf.setImage(with: URL(string: result.event_first_player_logo ?? "football.png"),
                                               placeholder: UIImage(named: "player"))
                    cell.team2ImgR.kf.setImage(with: URL(string: result.event_second_player_logo ?? "football.png"),
                                               placeholder: UIImage(named: "player"))
                    print(result.event_first_player_logo ?? "default value")
                } else {
                    cell.team1NameR.text = result.event_home_team
                    cell.team2NameR.text = result.event_away_team
                    cell.dateR.text = result.event_date
                    cell.resultR.text = result.event_final_result
                    cell.team1ImgR.kf.setImage(with: URL(string: result.home_team_logo ?? ""))
                    cell.team2ImgR.kf.setImage(with: URL(string: result.away_team_logo ?? ""))
                }
                cell.layer.borderWidth = 5
                cell.layer.borderColor = cell.contentView.backgroundColor?.cgColor


            }
            return cell

        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCollectionViewCell
            print(leaguesDetailsViewModel?.teams?.count)
            if let results = leaguesDetailsViewModel?.teams, indexPath.row < results.count {
                let result = results[indexPath.row]
                print(result.players?.count)
               
     
                cell.teamsLogo.kf.setImage(with: URL(string: result.team_logo ?? ""),
                    placeholder: UIImage(named: "team")
                )
                cell.teamsLogo.layer.cornerRadius = 25

            }
            return cell
            
        default:
            fatalError("Unexpected section \(indexPath.section)")
        }
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    /*
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the size for the header view
        return CGSize(width: collectionView.bounds.width, height: 50) // Adjust the height as needed
    }
    */
   /* override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       // if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterHeaderView.headerIdentifier, for: indexPath) as! FilterHeaderView
            return headerView
        //} else {
       //     fatalError("Unexpected supplementary view kind: \(kind)")
        //}
    }
    */
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

func getDates() -> (currentDate: String, nextYearDate: String, lastYearDate: String) {
    let currentYear = Date()
    
    let calendar = Calendar.current
    let nextYear = calendar.date(byAdding: .year, value: 1, to: currentYear)!
    let lastYear = calendar.date(byAdding: .year, value: -1, to: currentYear)!
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let currentDate = dateFormatter.string(from: currentYear)
    let nextYearDate = dateFormatter.string(from: nextYear)
    let lastYearDate = dateFormatter.string(from: lastYear)
    
    return (currentDate, nextYearDate, lastYearDate)
}


class CustomHeaderView: UICollectionReusableView {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
