//
//  SearcResultCollectionViewCell.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: BaseCollectionViewCell {
    let photoImageView = UIImageView()
    let likesContainerView = UIView()
    let starImageView = UIImageView()
    let likesLabel = UILabel()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemRed
        button.backgroundColor = UIColor(white: 1, alpha: 0.5)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likesContainerView)
        contentView.addSubview(likeButton)
        likesContainerView.addSubview(starImageView)
        likesContainerView.addSubview(likesLabel)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        likesContainerView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(10)
            make.height.equalTo(24)
        }
        
        starImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.size.equalTo(14)
        }
        
        likesLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.backgroundColor = .darkGray
        
        likesContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        likesContainerView.layer.cornerRadius = 12
        likesContainerView.clipsToBounds = true
        
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .systemYellow
        
        likesLabel.font = .boldSystemFont(ofSize: 12)
        likesLabel.textColor = .white
    }
}
