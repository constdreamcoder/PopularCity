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
        
        travelImageView.layer.cornerRadius = 8
    }

    
}
