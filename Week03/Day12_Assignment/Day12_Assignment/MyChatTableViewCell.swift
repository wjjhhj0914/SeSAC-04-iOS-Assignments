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
        
        myChatMessageView.layer.cornerRadius = 8
        myChatMessageView.clipsToBounds = true
        myChatMessageView.backgroundColor = .systemGray6
        myChatMessageView.layer.borderWidth = 1
        myChatMessageView.layer.borderColor = UIColor.lightGray.cgColor
        
        myChatTimeLabel.font = .systemFont(ofSize: 12)
        myChatMessageLabel.font = .systemFont(ofSize: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
