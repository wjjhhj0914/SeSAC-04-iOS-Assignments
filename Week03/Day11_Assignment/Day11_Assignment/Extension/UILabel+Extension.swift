//
//  UILabel+Extension.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/13/26.
//

import UIKit

extension UILabel {
    func setMainTitleLabel(titleText: String) {
        self.text = titleText
        self.font = .systemFont(ofSize: 17, weight: .heavy)
    }
    
    func setTitleLabel() {
        self.font = .systemFont(ofSize: 24, weight: .bold)
        self.textColor = .white
    }
    
    func setSubtitleLabel() {
        self.font = .systemFont(ofSize: 14)
        self.backgroundColor = .black
        self.layer.opacity = 0.5
        self.textColor = .white
    }
}
