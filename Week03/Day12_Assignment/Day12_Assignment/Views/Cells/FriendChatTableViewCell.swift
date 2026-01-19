//
//  FriendChatTableViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

import Kingfisher

class FriendChatTableViewCell: UITableViewCell {
    
    static let identifier = "FriendChatTableViewCell"
    
    @IBOutlet var chatRoomFriendImageView: UIImageView!
    @IBOutlet var chatRoomFriendNameLabel: UILabel!
    @IBOutlet var chatRoomFriendMessageLabelView: UIView!
    @IBOutlet var chatRoomFriendMessageLabel: UILabel!
    @IBOutlet var chatRoomFriendTimeLabel: UILabel!
    @IBOutlet var friendImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chatRoomFriendImageView.setupFriendImage()
        
        chatRoomFriendNameLabel.setupChatLabel(fontSize: 13)
        chatRoomFriendMessageLabel.setupChatLabel(fontSize: 14)
        chatRoomFriendTimeLabel.setupChatLabel(fontSize: 12)
        
        chatRoomFriendMessageLabelView.setupChatView(cornerRadius: 10, backgroundColour: .white, borderColour: UIColor.lightGray.cgColor)
    }
    
    func configure(friend: User?, message: Message, time: String) {
        // 친구가 있으면
        if friend != nil {
            chatRoomFriendNameLabel.text = friend!.userName
            let url = URL(string: friend!.profileImage)
            chatRoomFriendImageView.kf.setImage(with: url)
        } else {
            // 친구가 없으면
            chatRoomFriendNameLabel.text = "알 수 없음"
            chatRoomFriendImageView.image = UIImage(systemName: "person.circle")
        }
        
        chatRoomFriendMessageLabel.text = message.content
        chatRoomFriendTimeLabel.text = time
    }

    
}
