//
//  CityDetailTableViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/11/24.
//

import UIKit

class CityDetailTableViewCell: UITableViewCell {
    static let identifier = String(describing: CityDetailTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet var starImageViewList: [UIImageView]!
    @IBOutlet weak var saveLabel: UILabel!
    
    @IBOutlet weak var travelImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none

        travelImageView.layer.cornerRadius = 8

        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        descriptionlabel.numberOfLines = 0
        descriptionlabel.font = .systemFont(ofSize: 16, weight: .semibold)
        descriptionlabel.textColor = .darkGray
        
        saveLabel.textAlignment = .left
        saveLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        saveLabel.textColor = .lightGray
        
        starImageViewList.forEach {
            $0.image = UIImage(systemName: "star")
            $0.contentMode = .scaleAspectFit
            $0.tintColor = .systemYellow
        }
        
        travelImageView.contentMode = .scaleToFill
        
        heartImageView.image = UIImage(systemName: "heart")
        heartImageView.tintColor = .red
        heartImageView.contentMode = .scaleAspectFit
    }
    
    func setupData(_ travel: Travel) {
        let travelImageUrl = URL(string: travel.travel_image!)
        let placeholderImage = UIImage(named: "no_image")
        travelImageView.kf.setImage(with: travelImageUrl, placeholder: placeholderImage)
        titleLabel.text = travel.title!
        descriptionlabel.text = travel.description!
        saveLabel.text = "(\(Int.random(in: 0...5000))) · 저장 \(travel.save!.convertToDecimalType())"
        
        for (index, starImageView) in starImageViewList.enumerated() {
            if index < Int(travel.grade!) {
                starImageView.image = UIImage(systemName: "star.fill")
            } else if index == Int(travel.grade!) && (Int(travel.grade! * 10) % 10) >= 5 {
                starImageView.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
        }
        
        if travel.like! {
            heartImageView.image = UIImage(systemName: "heart")
        } else {
            heartImageView.image = UIImage(systemName: "heart.fill")
        }
    }

    
}
