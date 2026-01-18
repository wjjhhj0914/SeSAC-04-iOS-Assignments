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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        let myChatNib = UINib(nibName: MyChatTableViewCell.identifier, bundle: nil)
        chatTableView.register(myChatNib, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        
        let friendChatNib = UINib(nibName: FriendChatTableViewCell.identifier, bundle: nil)
        chatTableView.register(friendChatNib, forCellReuseIdentifier: FriendChatTableViewCell.identifier)
        
        chatTableView.separatorStyle = .none
        chatTableView.rowHeight = UITableView.automaticDimension
        
        var friendId = 0
        
        if chatData != nil {
            let idData = chatData!.participantIds
            
            for id in idData {
                if id != 0 {
                    friendId = id
                    break
                }
            }
        }
        
        for user in mockUsers {
            if user.userId == friendId {
                navigationItem.title = user.userName
                break
            }
        }

    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatData!.messages[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        let timeString = formatter.string(from: message.timestamp)
        
        if message.senderId == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell

            // 텍스트
            cell.myChatMessageLabel.text = message.content
            // 시간
            cell.myChatTimeLabel.text = timeString
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendChatTableViewCell", for: indexPath) as! FriendChatTableViewCell
            
            cell.chatRoomFriendMessageLabel.text = message.content
            
            // 친구 ID 찾기 (0이 아닌 번호 찾기)
            var friendId = 0
            let ids = chatData!.participantIds
            
            for id in ids {
                if id != 0 {
                    friendId = id
                    break
                }
            }
            
            for user in mockUsers {
                if user.userId == friendId {
                    // 이름 넣기
                    cell.chatRoomFriendNameLabel.text = user.userName
                    
                    // 이미지 넣기
                    let url = URL(string: user.profileImage)
                    cell.chatRoomFriendImageView.kf.setImage(with: url)
                    
                    break
                }
            }
            
            cell.chatRoomFriendTimeLabel.text = timeString
        
            return cell
        }
    }

}
