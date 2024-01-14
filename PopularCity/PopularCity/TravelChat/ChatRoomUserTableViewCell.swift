//
//  ChatRoomUserTableViewCell.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import UIKit

class ChatRoomUserTableViewCell: UITableViewCell {
    static let identifier = String(describing: ChatRoomUserTableViewCell.self)
    
    @IBOutlet weak var saperatorDateContainerView: UIView!
    @IBOutlet weak var saperatorDateLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var saperatorDateContainerViewHeightConstraint: NSLayoutConstraint!
    var saperatorDateContainerViewHeightConstraintInitialConstant: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        saperatorDateContainerView.layer.cornerRadius = 16
        saperatorDateContainerView.layer.borderWidth = 1
        saperatorDateContainerView.layer.borderColor = UIColor.darkGray.cgColor
        saperatorDateContainerView.backgroundColor = .systemGray6
        
        messageContainerView.layer.borderWidth = 1
        messageContainerView.layer.borderColor = UIColor.lightGray.cgColor
        messageContainerView.layer.cornerRadius = 8
        messageContainerView.backgroundColor = .systemGray5
        
        saperatorDateContainerViewHeightConstraintInitialConstant = saperatorDateContainerViewHeightConstraint.constant
        saperatorDateContainerViewHeightConstraint.constant = 0
    }

   
    
}
