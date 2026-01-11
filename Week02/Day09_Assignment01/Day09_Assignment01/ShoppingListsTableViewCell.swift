//
//  ShoppingListsTableViewCell.swift
//  Day09_Assignment01
//
//  Created by Hyojung Jang on 1/10/26.
//

import UIKit

class ShoppingListsTableViewCell: UITableViewCell {
    
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var favouriteButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var expirationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkButton.tintColor = UIColor.gray
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        
        dateLabel.textColor = UIColor.gray
        dateLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        
        expirationLabel.textColor = UIColor.systemRed
        expirationLabel.font = UIFont.boldSystemFont(ofSize: 12)
    }
}
