//
//  ChattingViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

import Kingfisher

class ChattingViewController: UIViewController {

    @IBOutlet var chatTableView: UITableView!
    
    var chatData: ChatRoom?
    
    @objc func friendImageButtonClicked() {
        print(#function)
        
        let vc = FriendProfileViewController()
        
        if let friend = chatData?.otherUser {
            vc.nickname = friend.userName
            vc.profileImageUrl = friend.profileImage
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationTitle()
    }
    
    private func setupTableView() {
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        let myChatNib = UINib(nibName: MyChatTableViewCell.identifier, bundle: nil)
        chatTableView.register(myChatNib, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        
        let friendChatNib = UINib(nibName: FriendChatTableViewCell.identifier, bundle: nil)
        chatTableView.register(friendChatNib, forCellReuseIdentifier: FriendChatTableViewCell.identifier)
        
        chatTableView.separatorStyle = .none
        chatTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupNavigationTitle() {
        let friend = chatData?.otherUser
        
        if friend != nil {
            navigationItem.title = friend!.userName
        } else {
            navigationItem.title = "채팅방"
        }
    }
    
    private func formateTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatData!.messages[indexPath.row]
        let timeString = formateTime(date: message.timestamp)
        
        if message.senderId == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            cell.configure(message: message, time: timeString)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendChatTableViewCell", for: indexPath) as! FriendChatTableViewCell
            cell.configure(friend: chatData?.otherUser, message: message, time: timeString)
            
            // 프로필 이미지 클릭하면 화면 전환
            cell.friendImageButton.addTarget(self, action: #selector(friendImageButtonClicked), for: .touchUpInside)
            return cell
        }
    }
}
