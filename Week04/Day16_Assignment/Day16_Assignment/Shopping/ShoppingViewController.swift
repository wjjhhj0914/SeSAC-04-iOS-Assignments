//
//  ShoppingViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit

class ShoppingViewController: UIViewController {
    
    let shoppingSearchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        
        configureHierarchy()
        configureLayout()
        configureView()
    }

}

extension ShoppingViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(shoppingSearchBar)
    }
    
    func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        shoppingSearchBar.searchBarStyle = .minimal
        shoppingSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
    }
    
    
}
