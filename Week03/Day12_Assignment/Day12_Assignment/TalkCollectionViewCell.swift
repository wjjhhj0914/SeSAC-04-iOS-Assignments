//
//  TalkCollectionViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

class TalkCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TalkCollectionViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
    }

}
