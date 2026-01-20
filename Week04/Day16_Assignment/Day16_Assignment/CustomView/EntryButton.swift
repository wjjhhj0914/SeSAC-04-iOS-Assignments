//
//  EntryButton.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

class EntryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("코드베이스")
    }
    
    init(titleStr: String) {
        super.init(frame: .zero)
        
        setTitle(titleStr, for: .normal)
        backgroundColor = .systemOrange
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
