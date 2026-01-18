//
//  FriendChatTableViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

class FriendChatTableViewCell: UITableViewCell {
    
    static let identifier = "FriendChatTableViewCell"
    
    @IBOutlet var chatRoomFriendImageView: UIImageView!
    @IBOutlet var chatRoomFriendNameLabel: UILabel!
    @IBOutlet var chatRoomFriendMessageLabelView: UIView!
    @IBOutlet var chatRoomFriendMessageLabel: UILabel!
    @IBOutlet var chatRoomFriendTimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chatRoomFriendImageView.layer.cornerRadius = chatRoomFriendImageView.frame.width / 2
        chatRoomFriendImageView.clipsToBounds = true
        
        chatRoomFriendMessageLabelView.layer.cornerRadius = 10
        
        chatRoomFriendNameLabel.font = .systemFont(ofSize: 13)
        chatRoomFriendMessageLabel.font = .systemFont(ofSize: 14)
        chatRoomFriendTimeLabel.font = .systemFont(ofSize: 12)
        
        chatRoomFriendMessageLabelView.layer.borderWidth = 1
        chatRoomFriendMessageLabelView.layer.borderColor = UIColor.lightGray.cgColor
        chatRoomFriendMessageLabelView.backgroundColor = .white
        
        chatRoomFriendMessageLabel.numberOfLines = 0
    }

    
}
