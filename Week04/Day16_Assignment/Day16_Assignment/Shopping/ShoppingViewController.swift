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

extension ShoppingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userInputText = searchBar.text ?? ""
        
        if userInputText.count < 2 {
            let alert = UIAlertController(title: "알림", message: "2글자 이상 입력해주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        
        let vc = SearchResultViewController()
        vc.searchKeyword = userInputText
        navigationController?.pushViewController(vc, animated: true)
        searchBar.resignFirstResponder()
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
        shoppingSearchBar.delegate = self
    }
}
