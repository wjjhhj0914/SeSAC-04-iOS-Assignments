//
//  HotPlacesCollectionViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/15/26.
//

import UIKit

class HotPlacesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HotPlacesCollectionViewCell"
    
    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var linkImageView: UIImageView!
    @IBOutlet var linkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let blue = UIColor(red: 221/255, green: 236/255, blue: 253/255, alpha: 1)
        
        setViewStyle(borderColour: blue, backgroundColour: blue)
        
        placeNameLabel.textAlignment = .center
        cityNameLabel.textAlignment = .center
        
        placeNameLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        cityNameLabel.font = .boldSystemFont(ofSize: 10)
        cityNameLabel.textColor = .gray
        
        linkImageView.image = UIImage(systemName: "link.circle.fill")
        linkImageView.tintColor = UIColor(red: 59/255, green: 134/255, blue: 247/255, alpha: 1)
        linkImageView.layer.borderWidth = 1
        linkImageView.layer.borderColor = UIColor.white.cgColor
        linkImageView.layer.cornerRadius = linkImageView.frame.width / 2
        linkImageView.clipsToBounds = true
    }
}
