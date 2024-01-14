//
//  ChatRoomViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import UIKit

class ChatRoomViewController: UIViewController {
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    
    @IBOutlet weak var inputTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputContainerViewBottomConstraint: NSLayoutConstraint!
    var inputContainerViewBottomConstraintInitialConstant: CGFloat = 0
    
    var chatroomName: String = ""
    var chatList: [Chat] = []
    
    var initialLineHeightOfInputTextView: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.title = chatroomName
        
        inputContainerView.layer.cornerRadius = 8
        
        inputTextView.delegate = self
        
        inputTextView.text = "메세지를 입력하세요"
        inputTextView.textColor = .lightGray
        
        initialLineHeightOfInputTextView = inputTextView.font?.lineHeight ?? 0
        
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        chatRoomTableView.separatorStyle = .none
        
        let chatRoomOtherUserTableViewCellXib = UINib(nibName: ChatRoomOtherUserTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(chatRoomOtherUserTableViewCellXib, forCellReuseIdentifier: ChatRoomOtherUserTableViewCell.identifier)
        
        let chatRoomUserTableViewCellXib = UINib(nibName: ChatRoomUserTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(chatRoomUserTableViewCellXib, forCellReuseIdentifier: ChatRoomUserTableViewCell.identifier)
        
        chatRoomTableView.scrollToRow(at: IndexPath(row: chatList.count - 1, section: 0), at: .bottom, animated: true)
        
        inputContainerViewBottomConstraintInitialConstant = inputContainerViewBottomConstraint.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    func addKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification){
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if #available(iOS 15.0, *) {
                let bottomInset = view.window?.windowScene?.keyWindow?.safeAreaInsets.bottom ?? 0
                let adjustedKeyboardHeight = keyboardHeight - bottomInset
                inputContainerViewBottomConstraint.constant = adjustedKeyboardHeight
            }
            else {
                inputContainerViewBottomConstraint.constant = keyboardHeight
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification){
        inputContainerViewBottomConstraint.constant = inputContainerViewBottomConstraintInitialConstant
        view.layoutIfNeeded()
    }
    
}

extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatList[indexPath.row]
        
        if chat.user == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomUserTableViewCell.identifier, for: indexPath) as! ChatRoomUserTableViewCell
            
            cell.messageLabel.text = chat.message
            cell.dateLabel.text = chat.date.convertToChatRoomDate
            
            if indexPath.row == 0 {
                cell.saperatorDateLabel.text = chat.date.convertToDateString
                cell.saperatorDateContainerViewHeightConstraint.constant = cell.saperatorDateContainerViewHeightConstraintInitialConstant
            } else if chat.date.convertToDateString != chatList[indexPath.row - 1].date.convertToDateString {
                cell.saperatorDateLabel.text = chat.date.convertToDateString
                cell.saperatorDateContainerViewHeightConstraint.constant = cell.saperatorDateContainerViewHeightConstraintInitialConstant
            } else {
                cell.saperatorDateContainerViewHeightConstraint.constant = 0
            }
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomOtherUserTableViewCell.identifier, for: indexPath) as! ChatRoomOtherUserTableViewCell
            
            cell.userProfileImageView.image = UIImage(named: chat.user.profileImage)
            cell.userNameLabel.text = chat.user.rawValue
            cell.messageLabel.text = chat.message
            cell.dateLabel.text = chat.date.convertToChatRoomDate
            
            if indexPath.row == 0 {
                cell.saperatorDateLabel.text = chat.date.convertToDateString
                cell.saperatorDateContainerViewHeightConstraint.constant = cell.saperatorDateContainerViewHeightConstraintInitialConstant
            } else if chat.date.convertToDateString != chatList[indexPath.row - 1].date.convertToDateString {
                cell.saperatorDateLabel.text = chat.date.convertToDateString
                cell.saperatorDateContainerViewHeightConstraint.constant = cell.saperatorDateContainerViewHeightConstraintInitialConstant
            } else {
                cell.saperatorDateContainerViewHeightConstraint.constant = 0
            }
            
            cell.selectionStyle = .none

            return cell
        }
    }
}

extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.size.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        guard textView.contentSize.height < initialLineHeightOfInputTextView * 2 else { textView.isScrollEnabled = true; return }
        
        textView.isScrollEnabled = false
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    
}
