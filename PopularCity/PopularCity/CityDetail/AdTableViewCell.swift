//
//  AdTableViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/11/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    static let identifier = String(describing: AdTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 8
        adLabel.layer.cornerRadius = 8
        adLabel.clipsToBounds = true
    }

    
    
}
