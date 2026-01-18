//
//  MyChatTableViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {
    
    @IBOutlet var myChatTimeLabel: UILabel!
    @IBOutlet var myChatMessageView: UIView!
    @IBOutlet var myChatMessageLabel: UILabel!
    
    static let identifier = "MyChatTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        myChatMessageView.setupChatView(cornerRadius: 10, backgroundColour: .systemGray6, borderColour: UIColor.lightGray.cgColor)
        
        myChatTimeLabel.setupChatLabel(fontSize: 12)
        myChatMessageLabel.setupChatLabel(fontSize: 14)
    }
    
    func configure(message: Message, time: String) {
        myChatMessageLabel.text = message.content
        myChatTimeLabel.text = time
    }
}
