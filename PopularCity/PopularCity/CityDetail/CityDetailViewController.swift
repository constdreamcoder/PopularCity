//
//  CityDetailViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/11/24.
//

import UIKit

struct Travel {
    let title: String?
    let description: String?
    let travel_image: String?
    let grade: Float?
    let save: Int?
    let like: Bool?
    let ad: Bool?
}

class CityDetailViewController: UIViewController {
    
    @IBOutlet weak var cityDetailTableView: UITableView!

    let travelList = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityDetailTableView.delegate = self
        cityDetailTableView.dataSource = self
        
        let adTableViewCellXib = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        cityDetailTableView.register(adTableViewCellXib, forCellReuseIdentifier: AdTableViewCell.identifier)
        
        let cityDetailTableViewCellXib = UINib(nibName: CityDetailTableViewCell.identifier, bundle: nil)
        cityDetailTableView.register(cityDetailTableViewCellXib, forCellReuseIdentifier: CityDetailTableViewCell.identifier)
        
        cityDetailTableView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "도서 상세 정보"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = "인기 도시"
    }

}

extension CityDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travelList[indexPath.row]
        
        if travel.ad! {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.titleLabel.text = travel.title
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailTableViewCell.identifier, for: indexPath) as! CityDetailTableViewCell
        cell.setupData(travel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = travelList[indexPath.row]
        
        if travel.ad! {
            let adVC = storyboard?.instantiateViewController(withIdentifier: "AdvertisementViewController") as! AdvertisementViewController
            let adNavVC = UINavigationController(rootViewController: adVC)
            present(adNavVC, animated: true, completion: nil)
            tableView.reloadData()
            return
        }
       
        let spotVC = storyboard?.instantiateViewController(withIdentifier: "SpotViewController") as! SpotViewController
        navigationController?.pushViewController(spotVC, animated: true)
    }
}
