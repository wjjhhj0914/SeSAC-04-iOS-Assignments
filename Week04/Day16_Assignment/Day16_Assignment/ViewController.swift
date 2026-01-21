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
    
    @objc func imageBtnClicked() {
        let vc = PicsumViewController()
        present(vc, animated: true)
    }
    
    @objc func boxOfficeBtnClicked() {
        let vc = BoxOfficeViewController()
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        imageBtn.addTarget(self, action: #selector(imageBtnClicked), for: .touchUpInside)
        boxOfficeBtn.addTarget(self, action: #selector(boxOfficeBtnClicked), for: .touchUpInside)
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
