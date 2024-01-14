//
//  TravelChatViewController.swift
//  PopularCity
//
//  Created by SUCHAN CHANG on 1/12/24.
//

import UIKit

class TravelTallkViewController: UIViewController {

    @IBOutlet weak var travelTalkTableView: UITableView!
    
    var mockChatRoomList = mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요"
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        
        travelTalkTableView.delegate = self
        travelTalkTableView.dataSource = self
        
        let travelChatRoomTableViewCellXib = UINib(nibName: TravelChatRoomTableViewCell.identifier, bundle: nil)
        travelTalkTableView.register(travelChatRoomTableViewCellXib, forCellReuseIdentifier: TravelChatRoomTableViewCell.identifier)
        
        travelTalkTableView.rowHeight = 80
        travelTalkTableView.showsVerticalScrollIndicator = false
    }
    
    func initializeTableViewList() {
        mockChatRoomList = mockChatList
    }
    
}

extension TravelTallkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockChatRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelChatRoomTableViewCell.identifier, for: indexPath) as! TravelChatRoomTableViewCell
        
        let chatRoom = mockChatRoomList[indexPath.row]
        
        cell.profileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
        cell.chatRoomNameLabel.text = chatRoom.chatroomName
        cell.messageLabel.text = chatRoom.chatList.last!.message
        cell.dateLabel.text = chatRoom.chatList.last!.date.convertToChatListDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = storyboard?.instantiateViewController(identifier: "ChatRoomViewController") as! ChatRoomViewController
        
        let chatRoom = mockChatRoomList[indexPath.row]

        chatRoomVC.chatroomName = chatRoom.chatroomName
        chatRoomVC.chatList = chatRoom.chatList
        
        navigationController?.pushViewController(chatRoomVC, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension TravelTallkViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            initializeTableViewList()
            travelTalkTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            initializeTableViewList()
        } else {
            let searchResult = mockChatRoomList.filter { $0.chatroomName.contains(searchBar.text!) }
            mockChatRoomList = searchResult
        }
       
        travelTalkTableView.reloadData()
    }
}
