//
//  BooksTableViewCell.swift
//  Day09_Assignment02
//
//  Created by Hyojung Jang on 1/11/26.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    @IBOutlet var bestsellerBadget: UILabel!
    @IBOutlet var bookTitleLabel: UILabel!
    
    @IBOutlet var authorImage: UIImageView!
    @IBOutlet var authorNameLabel: UILabel!
    
    @IBOutlet var priceView: UIView!
    @IBOutlet var priceImage: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceOfBookLabel: UILabel!
    
    @IBOutlet var ratingView: UIView!
    @IBOutlet var ratingImage: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var ratingOfBookLabel: UILabel!
    
    @IBOutlet var pageView: UIView!
    @IBOutlet var pageImage: UIImageView!
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var pageOfBookLabel: UILabel!
    
    @IBOutlet var yearView: UIView!
    @IBOutlet var yearImage: UIImageView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var yearOfPublicationLabel: UILabel!
    
    @IBOutlet var genreView: UIView!
    @IBOutlet var genreLabel: UILabel!
    
    func setViewDesign(view: UIView) {
        view.layer.cornerRadius = 14
        view.backgroundColor = .systemGray6
    }
    
    func setBadgetDesign(label: UILabel) {
        label.backgroundColor = .systemYellow
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
    }
    
    func setTitleLabelDesign(label: UILabel) {
        label.textColor = .gray
        label.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    func setContentLabelDesign(label: UILabel) {
        label.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    func setImageDesign(image: UIImageView) {
        image.tintColor = .gray
    }
    
    func setLabelDesign(label: UILabel, colour: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        label.textColor = colour
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setBadgetDesign(label: bestsellerBadget)
        setLabelDesign(label: bookTitleLabel, colour: .black, fontSize: 20, fontWeight: .heavy)
        setLabelDesign(label: genreLabel, colour: .black, fontSize: 14, fontWeight: .bold)
        setLabelDesign(label: authorNameLabel, colour: .gray, fontSize: 14, fontWeight: .bold)
        
        setTitleLabelDesign(label: priceLabel)
        setTitleLabelDesign(label: ratingLabel)
        setTitleLabelDesign(label: pageLabel)
        setTitleLabelDesign(label: yearLabel)
        
        setContentLabelDesign(label: priceOfBookLabel)
        setContentLabelDesign(label: ratingOfBookLabel)
        setContentLabelDesign(label: pageOfBookLabel)
        setContentLabelDesign(label: yearOfPublicationLabel)

        setViewDesign(view: priceView)
        setViewDesign(view: ratingView)
        setViewDesign(view: pageView)
        setViewDesign(view: yearView)
        setViewDesign(view: genreView)
        
        setImageDesign(image: authorImage)
        setImageDesign(image: priceImage)
        setImageDesign(image: ratingImage)
        setImageDesign(image: pageImage)
        setImageDesign(image: yearImage)
    }
}
