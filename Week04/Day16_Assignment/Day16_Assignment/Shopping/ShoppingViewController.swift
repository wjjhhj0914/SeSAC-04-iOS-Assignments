//
//  ShoppingViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit

class ShoppingViewController: BaseViewController {
    
    let shoppingSearchBar = UISearchBar()
    let deleteAllBtn = UIButton()
    
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
        list = UserDefaultManager.searchHistory
    }
    
    func handleSearch(keyword: String) {
        let currentHistory = UserDefaultManager.searchHistory
        var userSearchedList: [String] = [keyword]
        
        for searchedItem in currentHistory {
            if searchedItem != keyword {
                userSearchedList.append(searchedItem)
            }
        }
        
        UserDefaultManager.searchHistory = userSearchedList
        list = userSearchedList
        
        let vc = SearchResultViewController()
        vc.searchKeyword = keyword
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(shoppingSearchBar)
        view.addSubview(myTableView)
        view.addSubview(deleteAllBtn)
    }
    
    override func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        deleteAllBtn.snp.makeConstraints { make in
            make.top.equalTo(shoppingSearchBar.snp.bottom).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(deleteAllBtn.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black
        
        shoppingSearchBar.searchBarStyle = .minimal
        shoppingSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        shoppingSearchBar.delegate = self
        
        deleteAllBtn.setTitle("전체 삭제", for: .normal)
        deleteAllBtn.setTitleColor(.gray, for: .normal)
        deleteAllBtn.titleLabel?.font = .boldSystemFont(ofSize: 12)
        
        deleteAllBtn.addTarget(self, action: #selector(deleteAllBtnClicked), for: .touchUpInside)
    }
    
    @objc func deleteAllBtnClicked(_ sender: UIButton) {
        let emptyList: [String] = []
        UserDefaultManager.searchHistory = emptyList
        self.list = emptyList
    }
    
    @objc func deleteBtnClicked(_ sender: UIButton) {
        let indexToDelete = sender.tag
        let currentList = self.list
        var newList: [String] = []
        
        for i in 0..<currentList.count {
            if i != indexToDelete {
                newList.append(currentList[i])
            }
        }
        
        UserDefaultManager.searchHistory = newList
        self.list = newList
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
        
        handleSearch(keyword: userInputText)
        searchBar.resignFirstResponder()
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedKeyword = list[indexPath.row]
        shoppingSearchBar.text = selectedKeyword
        
        handleSearch(keyword: selectedKeyword)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchKeywordTableViewCell.identifier) as! RecentSearchKeywordTableViewCell
        cell.resultLabel.text = list[indexPath.row]
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        
        return cell
    }
}
