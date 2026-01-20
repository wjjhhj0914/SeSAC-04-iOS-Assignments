//
//  boxOfficeSearchButton.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

class BoxOfficeSearchButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(titleStr: String) {
        super.init(frame: .zero)
        
        setTitle(titleStr, for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
