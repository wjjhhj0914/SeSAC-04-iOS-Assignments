//
//  Extension+UIViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 2/2/26.
//

import UIKit

extension UIViewController {
    func setupLabel<T: UILabel>(label: T, fontSize: CGFloat, weight: UIFont.Weight = .bold) {
        label.font = .systemFont(ofSize: fontSize, weight: weight)
    }
}
