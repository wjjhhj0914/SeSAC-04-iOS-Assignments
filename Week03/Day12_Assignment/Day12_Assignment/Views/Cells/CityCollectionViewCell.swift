//
//  CityCollectionViewCell.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CityCollectionViewCell"
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var cityButton: UIButton!
    @IBOutlet var cityImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cityName.font = .systemFont(ofSize: 20, weight: .heavy)
        cityName.textAlignment = .center
        locationLabel.font = .systemFont(ofSize: 12)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
        locationLabel.textColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityImage.layer.cornerRadius = cityImage.frame.width / 2
        cityImage.clipsToBounds = true
    }

}
