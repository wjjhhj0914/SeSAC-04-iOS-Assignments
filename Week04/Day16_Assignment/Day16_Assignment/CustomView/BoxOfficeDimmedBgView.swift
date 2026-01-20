//
//  BoxOfficeDimmedBgView.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit
import Kingfisher

class BoxOfficeDimmedBgView: UIView {
    let bgImageView = UIImageView()
    let backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(bgImgUrl: String) {
        super.init(frame: .zero)
        
        addSubview(bgImageView)
        addSubview(backgroundView)
        
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.kf.setImage(with: URL(string: bgImgUrl))
        
        backgroundView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(bgImageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
