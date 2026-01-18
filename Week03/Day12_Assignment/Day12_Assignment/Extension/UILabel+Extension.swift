//
//  UILabel+Extension.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

extension UILabel {
    func setupChatLabel(fontSize: CGFloat, textColour: UIColor = .black) {
        self.font = .systemFont(ofSize: fontSize)
        self.textColor = textColour
    }
}
