//
//  HotPlacesDetailsViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/19/26.
//

import UIKit

import SnapKit

class HotPlacesDetailsViewController: UIViewController {
    
    private let infoTextView = UITextView()
    
    var spot: TouristSpot?

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6

        setupHierarchy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierarchy() {
        view.addSubview(infoTextView)
    }
    
    private func setupConstraints() {
        infoTextView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func configureView() {
        if let spot = spot {
            navigationItem.title = spot.koreanName
            
            infoTextView.layer.cornerRadius = 14
            
            infoTextView.dataDetectorTypes = .all
            infoTextView.isEditable = false
            infoTextView.isSelectable = true
            infoTextView.font = .systemFont(ofSize: 14)
            
            infoTextView.text = """
            장소명
            \(spot.englishName)
            
            도시
            \(spot.city)
            
            주소
            \(spot.address)
            
            전화번호
            \(spot.phoneNumber)
            
            웹사이트
            \(spot.websiteURL)
            """
        } else {
            infoTextView.text = "정보를 불러올 수 없습니다."
            infoTextView.textAlignment = .center
        }
        
    }
}
