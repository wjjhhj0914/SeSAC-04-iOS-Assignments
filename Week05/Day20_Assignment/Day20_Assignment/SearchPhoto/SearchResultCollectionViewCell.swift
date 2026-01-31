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
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likesContainerView)
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
    }
    
    override func configureView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 12
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
