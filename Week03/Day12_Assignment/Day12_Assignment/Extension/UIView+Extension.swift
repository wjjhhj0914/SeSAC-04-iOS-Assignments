//
//  UIView+Extension.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/16/26.
//

import UIKit

extension UIView {
    func setViewStyle(borderColour: UIColor, backgroundColour: UIColor) {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = borderColour.cgColor
        self.backgroundColor = backgroundColour
    }
    
    func setupChatView(cornerRadius: CGFloat, backgroundColour: UIColor, borderWidth: CGFloat = 1, borderColour: CGColor) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.backgroundColor = backgroundColour
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColour
    }
}
