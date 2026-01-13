//
//  UITextField+Extension.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/14/26.
//

import UIKit

extension UITextField {
    func setTextField(placeholderText: String) {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray6.cgColor
        self.clipsToBounds = true
        self.placeholder = placeholderText
    }
}
