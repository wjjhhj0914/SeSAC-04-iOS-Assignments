//
//  BoxOfficeSearchTextField.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

import SnapKit

class BoxOfficeSearchTextField: UITextField {
    let underLineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(placeholderText: String) {
        super.init(frame: .zero)
        
        addSubview(underLineView)
        
        placeholder = placeholderText
        borderStyle = .none
        textColor = .white
        
        underLineView.backgroundColor = .white
        underLineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
