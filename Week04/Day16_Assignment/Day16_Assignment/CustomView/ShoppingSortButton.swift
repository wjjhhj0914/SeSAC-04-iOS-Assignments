//
//  ShoppingSortButton.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

class ShoppingSortButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(titleStr: String) {
        super.init(frame: .zero)
        
        var myConfig = UIButton.Configuration.plain()
        
        titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        myConfig.title = titleStr
        myConfig.baseForegroundColor = .white
        myConfig.background.cornerRadius = 8
        myConfig.background.strokeWidth = 1
        myConfig.background.strokeColor = .white
        myConfig.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        self.configuration = myConfig
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
