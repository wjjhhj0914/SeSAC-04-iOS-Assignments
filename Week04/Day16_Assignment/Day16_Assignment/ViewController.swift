//
//  ViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    let imageBtn = EntryButton(titleStr: "이미지")
    let boxOfficeBtn = EntryButton(titleStr: "박스 오피스")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension ViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(imageBtn)
        view.addSubview(boxOfficeBtn)
    }
    
    func configureLayout() {
        imageBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(300)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        boxOfficeBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(imageBtn).offset(80)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    
}
