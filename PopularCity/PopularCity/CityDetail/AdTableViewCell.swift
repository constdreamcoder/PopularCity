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
    
    let backgroundColorList: [UIColor] = [.gray, .lightGray, .blue, .brown, .green, .magenta , .cyan, .systemTeal, .orange, .systemMint, .purple, .yellow]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = backgroundColorList.randomElement()
        layer.cornerRadius = 8
        
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        adLabel.layer.cornerRadius = 8
        adLabel.clipsToBounds = true
        adLabel.text = "AD"
        adLabel.textAlignment = .center
        adLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }

}
