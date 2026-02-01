//
//  ColorChipButton.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/28/26.
//

import UIKit

class ColorChipButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.baseBackgroundColor = .systemGray6
        config.baseForegroundColor = .black
        config.background.cornerRadius = 20
        
        self.configuration = config
    }
    
    func configure(title: String) {
        var config = self.configuration //현재 설정 가져옴
        
        var container = AttributeContainer()
        container.font = .boldSystemFont(ofSize: 14)
        config?.attributedTitle = AttributedString(title, attributes: container)
        
        self.configuration = config // 바뀐 설정 다시 적용
    }
}
