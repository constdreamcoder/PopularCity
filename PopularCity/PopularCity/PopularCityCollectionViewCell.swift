//
//  PopularCityCollectionViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/9/24.
//

import UIKit

class PopularCityCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PopularCityCollectionViewCell.self)
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
        
        cityDescriptionLabel.numberOfLines = 2
        cityDescriptionLabel.textAlignment = .center
        cityDescriptionLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
        cityDescriptionLabel.textColor = .systemGray2
    }

}
