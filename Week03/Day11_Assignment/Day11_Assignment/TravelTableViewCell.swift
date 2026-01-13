//
//  TravelTableViewCell.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/13/26.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    static let identifier = "TravelTableViewCell"
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityImageButton: UIButton!
    @IBOutlet var cityExplainLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        cityNameLabel.textColor = .white
        
        cityExplainLabel.font = .systemFont(ofSize: 14)
        cityExplainLabel.backgroundColor = .black
        cityExplainLabel.layer.opacity = 0.5
        cityExplainLabel.textColor = .white
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        cityImageView.image = nil
    }

}
