//
//  PicsumLabel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

class PicsumLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(fontSize: CGFloat, textColour: UIColor = .black) {
        super.init(frame: .zero)
        font = .boldSystemFont(ofSize: fontSize)
        textColor = textColour
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
