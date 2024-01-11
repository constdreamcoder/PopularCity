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
        
        guard
            let title = travel.title,
            let description = travel.description,
            let save = travel.save,
            let travelImage = travel.travel_image,
            let grade = travel.grade,
            let like = travel.like
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            cell.titleLabel.text = travel.title
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailTableViewCell.identifier, for: indexPath) as! CityDetailTableViewCell
        
        let travelImageUrl = URL(string: travelImage)
        cell.travelImageView.kf.setImage(with: travelImageUrl)
        cell.titleLabel.text = title
        cell.descriptionlabel.text = description
        cell.saveLabel.text = "(\(Int.random(in: 0...5000))) · 저장 \(save.convertToDecimalType())"
        
        for (index, starImageView) in cell.starImageViewList.enumerated() {
            if index < Int(grade) {
                starImageView.image = UIImage(systemName: "star.fill")
            } else if index == Int(grade) && (Int(grade * 10) % 10) >= 5 {
                starImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
        }
        
        if like {
            cell.heartImageView.image = UIImage(systemName: "heart")
        } else {
            cell.heartImageView.image = UIImage(systemName: "heart.fill")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = travelList[indexPath.row]
        
        guard
            let _ = travel.title,
            let _ = travel.description,
            let _ = travel.save,
            let _ = travel.travel_image
        else {
            let adVC = storyboard?.instantiateViewController(withIdentifier: "AdvertisementViewController") as! AdvertisementViewController
            let adNavVC = UINavigationController(rootViewController: adVC)
            present(adNavVC, animated: true, completion: nil)
            return
            
        }
        let spotVC = storyboard?.instantiateViewController(withIdentifier: "SpotViewController") as! SpotViewController
        navigationController?.pushViewController(spotVC, animated: true)
       
    }
    
    
}
