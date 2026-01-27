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
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        photoImageView.backgroundColor = .darkGray
    }
}
