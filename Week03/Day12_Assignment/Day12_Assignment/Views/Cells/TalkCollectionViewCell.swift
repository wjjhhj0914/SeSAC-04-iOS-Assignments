//
//  TalkCollectionViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

import Kingfisher

class TalkCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TalkCollectionViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.profileImageView.setupFriendImage()
        }
        
        nameLabel.setupChatLabel(fontSize: 15)
        messageLabel.setupChatLabel(fontSize: 14, textColour: .gray)
        dateLabel.setupChatLabel(fontSize: 12, textColour: .gray)
    }
    
    func configure(data: ChatRoom) {
        let friend = data.otherUser
            
        if friend != nil {
            nameLabel.text = friend!.userName
            let url = URL(string: friend!.profileImage)
            profileImageView.kf.setImage(with: url)
        } else {
            nameLabel.text = "알 수 없음"
            profileImageView.image = UIImage(systemName: "person.circle")
        }
        
        if data.messages.count > 0 {
            let lastChat = data.messages[data.messages.count - 1]
            messageLabel.text = lastChat.content
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yy.MM.dd"
            dateLabel.text = formatter.string(from: lastChat.timestamp)
        }
    }

}
