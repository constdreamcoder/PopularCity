//
//  PopularCityCollectionViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/9/24.
//

import UIKit

final class PopularCityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionViewCellUI()
    }
    

    // 방법 4
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        cityImageView.layer.cornerRadius = cityImageView.frame.width / 2
//    }
    
    // 방법 3
//    override func draw(_ rect: CGRect) {
//        cityImageView.layer.cornerRadius = cityImageView.frame.width / 2
//    }
    
    // 방법2
    override func setNeedsLayout() {
        super.setNeedsLayout()
        cityImageView.layer.cornerRadius = cityImageView.frame.width / 2
    }
    
    func changeTextColorPartially(with text: String) {            
        [
            cityNameLabel,
            cityDescriptionLabel
        ].forEach { label in
            let attributedString = NSMutableAttributedString(string: label.text ?? "")
            
            attributedString.addAttribute(.backgroundColor, value: UIColor.yellow, range: ((label.text ?? "") as NSString).range(of: text))
            
            label.attributedText = attributedString
        }
    }

}

extension PopularCityCollectionViewCell: CollectionViewCellUIProtocol {
    static let identifier = String(describing: PopularCityCollectionViewCell.self)

    func configureCollectionViewCellUI() {
        cityImageView.contentMode = .scaleAspectFill
        
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = .systemFont(ofSize: 18.0, weight: .bold)
        
        cityDescriptionLabel.numberOfLines = 2
        cityDescriptionLabel.textAlignment = .center
        cityDescriptionLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
        cityDescriptionLabel.textColor = .systemGray2
    }
}
