//
//  AdCollectionViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/15/26.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AdCollectionViewCell"

    @IBOutlet var adBadgetLabel: UILabel!
    @IBOutlet var adNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let salmon = UIColor(red: 248/255, green: 214/255, blue: 172/255, alpha: 1)
        let lightYellow = UIColor(red: 251/255, green: 241/255, blue: 185/255, alpha: 1)
        
        setViewStyle(borderColour: salmon, backgroundColour: lightYellow)
        
        adBadgetLabel.textAlignment = .center
        adBadgetLabel.font = .monospacedDigitSystemFont(ofSize: 10, weight: .heavy)
        adBadgetLabel.backgroundColor = .systemOrange
        adBadgetLabel.textColor = .white
        adBadgetLabel.layer.cornerRadius = 10
        adBadgetLabel.clipsToBounds = true
        
        adNameLabel.textAlignment = .center
        adNameLabel.font = .boldSystemFont(ofSize: 12)
    }
}
