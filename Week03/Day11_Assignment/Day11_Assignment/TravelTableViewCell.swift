//
//  TravelTableViewCell.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/13/26.
//

import UIKit

import Kingfisher

class TravelTableViewCell: UITableViewCell {
    
    static let identifier = "TravelTableViewCell"

    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityImageButton: UIButton!
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityNameLabel.setTitleLabel()
        cityExplainLabel.setSubtitleLabel()
    }
    
    func configure(row: City) {
        let url = URL(string: row.city_image)
        cityImageView.kf.setImage(with: url)
        
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cityExplainLabel.text = "  " + row.city_explain
    }
}
