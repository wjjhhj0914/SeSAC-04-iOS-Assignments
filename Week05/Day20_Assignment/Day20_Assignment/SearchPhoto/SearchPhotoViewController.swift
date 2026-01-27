//
//  SearchPhotoViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/26/26.
//

import UIKit
import SnapKit

class SearchPhotoViewController: BaseViewController {
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SEARCH PHOTO"
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
    }
}

// 검색
extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            showAlert(title: "알림", message: "검색어를 입력해 주세요!")
            return
        }
        callRequest(query: text)
        view.endEditing(true)
    }
}
