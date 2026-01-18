//
//  UIImageView+Extension.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

extension UIImageView {
    func setupFriendImage() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
