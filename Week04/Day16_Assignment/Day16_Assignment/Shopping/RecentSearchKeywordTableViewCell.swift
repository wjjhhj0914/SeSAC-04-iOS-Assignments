//
//  RecentSearchKeywordTableViewCell.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/22/26.
//

import UIKit

import SnapKit

class RecentSearchKeywordTableViewCell: UITableViewCell {
    static let identifier = "RecentSearchKeywordTableViewCell"
    
    let searchImgBtn = UIImageView()
    let resultLabel = UILabel()
    let deleteBtn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RecentSearchKeywordTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(searchImgBtn)
        contentView.addSubview(resultLabel)
        contentView.addSubview(deleteBtn)
    }
    
    func configureLayout() {
        searchImgBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchImgBtn.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(deleteBtn.snp.leading).offset(-12)
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
    }
    
    func configureView() {
        self.backgroundColor = .black
        
        searchImgBtn.image = UIImage(systemName: "magnifyingglass")
        searchImgBtn.tintColor = .gray
        searchImgBtn.contentMode = .scaleAspectFit
        
        resultLabel.textColor = .white
        resultLabel.font = .boldSystemFont(ofSize: 14)
        
        deleteBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteBtn.tintColor = .gray
    }
}
