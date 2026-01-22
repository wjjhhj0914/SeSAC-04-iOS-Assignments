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
    
    lazy var myTableView = {
        let recentSearchKeywordTableView = UITableView()
        
        recentSearchKeywordTableView.backgroundColor = .black
        recentSearchKeywordTableView.delegate = self
        recentSearchKeywordTableView.dataSource = self
        recentSearchKeywordTableView.register(RecentSearchKeywordTableViewCell.self, forCellReuseIdentifier: RecentSearchKeywordTableViewCell.identifier)
        
        return recentSearchKeywordTableView
    }()
    
    var list: [String] = [] {
        didSet {
            // 바구니 바뀌면 테이블뷰 리로드
            myTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        list = UserDefaultManager.searchHistory
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
            return
        }
        
        let currentHistory = UserDefaultManager.searchHistory
        
        var userSearchedList: [String] = [userInputText]
        
        for searchedItem in currentHistory {
            if searchedItem != userInputText {
                userSearchedList.append(searchedItem)
            }
        }
        
        UserDefaultManager.searchHistory = userSearchedList
        list = userSearchedList
        
        let vc = SearchResultViewController()
        vc.searchKeyword = userInputText
        navigationController?.pushViewController(vc, animated: true)
        searchBar.resignFirstResponder()
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchKeywordTableViewCell.identifier) as! RecentSearchKeywordTableViewCell
        
        cell.resultLabel.text = list[indexPath.row]
        
        return cell
    }
}

extension ShoppingViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(shoppingSearchBar)
        view.addSubview(myTableView)
    }
    
    func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(shoppingSearchBar.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        shoppingSearchBar.searchBarStyle = .minimal
        shoppingSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        shoppingSearchBar.delegate = self
    }
}
