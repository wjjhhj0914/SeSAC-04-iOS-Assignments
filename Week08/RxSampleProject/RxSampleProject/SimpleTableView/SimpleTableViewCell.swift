//
//  SimpleTableViewCell.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/22/26.
//

import UIKit
import SnapKit

final class SimpleTableViewCell: BaseTableViewCell {
    
    static let identifier = "SimpleTableViewCell"
    
    let simpleLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(simpleLabel)
    }
    
    override func configureLayout() {
        simpleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
    }
    
    override func configureView() {
        accessoryType = .detailButton
    }
}
