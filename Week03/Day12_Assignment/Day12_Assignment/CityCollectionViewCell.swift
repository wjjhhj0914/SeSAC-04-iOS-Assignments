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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.text = "서울"
        locationLabel.text = "서울, 남산타워, 롯데타워, 경복궁"
        
        cityName.font = .systemFont(ofSize: 20, weight: .heavy)
        cityName.textAlignment = .center
        locationLabel.font = .systemFont(ofSize: 12)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
    }

}
