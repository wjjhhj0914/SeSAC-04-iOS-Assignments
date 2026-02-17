//
//  SearchResultCollectionViewCell.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit

class SearchResultCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "SearchResultCollectionViewCell"
    
    let productImageView = UIImageView()
    let mallNameLabel = UILabel()
    let productNameLabel = UILabel()
    let productPriceLabel = UILabel()
    let likeButton = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        productImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(productImageView.snp.width)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(productImageView).inset(8)
            make.size.equalTo(30)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(4)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(4)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    override func configureView() {
        productImageView.layer.cornerRadius = 12
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleToFill
        productImageView.image = UIImage(systemName: "person.circle.fill")
        
        mallNameLabel.font = .systemFont(ofSize: 12)
        mallNameLabel.textColor = .lightGray
        
        productNameLabel.font = .systemFont(ofSize: 13)
        productNameLabel.textColor = .white
        productNameLabel.numberOfLines = 2
        
        productPriceLabel.font = .boldSystemFont(ofSize: 16)
        productPriceLabel.textColor = .white
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.backgroundColor = .white
        likeButton.layer.cornerRadius = 15
        likeButton.tintColor = .black
    }
}
