//
//  BoxOfficeTableViewCell.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit

class BoxOfficeTableViewCell: UITableViewCell {
    static let identifier = "BoxOfficeTableViewCell"
    
    let boxOfficeRankLabel = BoxOfficeLabel(textColour: .black, fontSize: 16)
    let movieTitleLabel = BoxOfficeLabel(fontSize: 16)
    let dateLabel = BoxOfficeLabel(fontSize: 12)

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

extension BoxOfficeTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(boxOfficeRankLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        boxOfficeRankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(boxOfficeRankLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        
        boxOfficeRankLabel.backgroundColor = .white
        boxOfficeRankLabel.textAlignment = .center
    }
}
