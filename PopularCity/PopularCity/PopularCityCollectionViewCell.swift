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
        
        NotificationCenter.default.addObserver(self, selector: #selector(heightSearchedKeyword), name: .HighlightSearchedKeywords, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func heightSearchedKeyword(_ notification: Notification) {
        if let text = notification.object as? String {
            let attributedString = NSMutableAttributedString(string: cityNameLabel.text ?? "")
            print(text)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: ((cityNameLabel.text ?? "") as NSString).range(of:text))
            
            cityNameLabel.attributedText = attributedString
        }
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
