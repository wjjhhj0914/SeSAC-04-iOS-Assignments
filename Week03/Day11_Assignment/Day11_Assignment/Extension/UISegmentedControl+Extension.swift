//
//  UISegmentedControl+Extension.swift
//  Day11_Assignment
//
//  Created by Hyojung Jang on 1/13/26.
//

import UIKit

extension UISegmentedControl {
    func setSegmentTitle() {
        self.setTitle("도시", forSegmentAt: 0)
        self.setTitle("국내", forSegmentAt: 1)
        self.setTitle("해외", forSegmentAt: 2)
    }
}
