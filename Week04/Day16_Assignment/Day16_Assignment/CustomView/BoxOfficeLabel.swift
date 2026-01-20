//
//  BoxOfficeLabel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

class BoxOfficeLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(textStr: String, textColour: UIColor = .white, fontSize: CGFloat) {
        super.init(frame: .zero)
        text = textStr
        textColor = textColour
        font = .boldSystemFont(ofSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
