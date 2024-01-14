//
//  TravelChatRoomTableViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import UIKit

class TravelTalkChatRoomTableViewCell: UITableViewCell {
    static let identifier = String(describing: TravelTalkChatRoomTableViewCell.self)
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var chatRoomNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        profileImageView.backgroundColor = .systemGray5
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
}
