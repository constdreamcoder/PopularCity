//
//  ChatRoomOtherUserTableViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import UIKit

class ChatRoomOtherUserTableViewCell: UITableViewCell {
    static let identifier = String(describing: ChatRoomOtherUserTableViewCell.self)
    
    @IBOutlet weak var saperatorDateContainerView: UIView!
    @IBOutlet weak var saperatorDateLabel: UILabel!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var saperatorDateContainerViewHeightConstraint: NSLayoutConstraint!
    var saperatorDateContainerViewHeightConstraintInitialConstant: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        userProfileImageView.backgroundColor = .systemGray5
        
        saperatorDateContainerView.layer.cornerRadius = 16
        saperatorDateContainerView.layer.borderWidth = 1
        saperatorDateContainerView.layer.borderColor = UIColor.darkGray.cgColor
        saperatorDateContainerView.backgroundColor = .systemGray6
        
        messageContainerView.layer.borderWidth = 1
        messageContainerView.layer.borderColor = UIColor.lightGray.cgColor
        messageContainerView.layer.cornerRadius = 8
        
        saperatorDateContainerViewHeightConstraintInitialConstant = saperatorDateContainerViewHeightConstraint.constant
        saperatorDateContainerViewHeightConstraint.constant = 0
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
    }
    
}
