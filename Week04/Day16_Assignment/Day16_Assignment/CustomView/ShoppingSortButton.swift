//
//  ShoppingSortButton.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

class ShoppingSortButton: UIButton {
    override var isSelected: Bool {
        didSet {
            changeBtnDesign(isSelected: isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(titleStr: String) {
        super.init(frame: .zero)
        
        self.setTitle(titleStr, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 12)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        changeBtnDesign(isSelected: isSelected)
    }
    
    func changeBtnDesign(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
        } else {
            self.backgroundColor = .black
            self.setTitleColor(.white, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
