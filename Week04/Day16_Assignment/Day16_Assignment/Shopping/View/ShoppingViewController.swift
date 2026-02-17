//
//  ShoppingViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit

class ShoppingViewController: BaseViewController {
    
    private let shoppingSearchBar = UISearchBar()
    private let deleteAllBtn = UIButton()
    private lazy var myTableView = {
        let recentSearchKeywordTableView = UITableView()
        
        recentSearchKeywordTableView.backgroundColor = .black
        recentSearchKeywordTableView.delegate = self
        recentSearchKeywordTableView.dataSource = self
        recentSearchKeywordTableView.register(RecentSearchKeywordTableViewCell.self, forCellReuseIdentifier: RecentSearchKeywordTableViewCell.identifier)
        
        return recentSearchKeywordTableView
    }()
    
    let viewModel = ShoppingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItems()
        
        print("ShoppingViewController ViewDidLoad")
        
        viewModel.outputSearchHistory.bind { _ in
            print("viewModel.outputSearchHistory.bind")
            self.myTableView.reloadData()
        }
        
        viewModel.outputAlertMessage.lazyBind { value in
            print("viewModel.outputAlertMessage.lazyBind")
            let alert = UIAlertController(title: "알림", message: value, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        viewModel.outputValidSearchKeyword.lazyBind { value in
            print("viewModel.outputValidSearchKeyword.bind")
            let vc = SearchResultViewController()
            vc.searchKeyword = value
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(shoppingSearchBar)
        view.addSubview(myTableView)
        view.addSubview(deleteAllBtn)
        
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
        
        shoppingSearchBar.searchBarStyle = .minimal
        shoppingSearchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        shoppingSearchBar.delegate = self
        
        deleteAllBtn.setTitle("전체 삭제", for: .normal)
        deleteAllBtn.setTitleColor(.gray, for: .normal)
        deleteAllBtn.titleLabel?.font = .boldSystemFont(ofSize: 12)
        
        deleteAllBtn.addTarget(self, action: #selector(deleteAllBtnClicked), for: .touchUpInside)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "도봉러의 쇼핑쇼핑"
    }
    
    @objc private func deleteAllBtnClicked() {
        viewModel.inputDeleteAllButtonClicked.value = ()
    }
    
    @objc private func deleteBtnClicked(_ sender: UIButton) {
        viewModel.inputDeleteButtonClicked.value = sender.tag
    }
}

extension ShoppingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchKeyword.value = searchBar.text ?? ""
        viewModel.inputSearchButtonClicked.value = ()
        searchBar.resignFirstResponder()
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputSearchHistory.value.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedKeyword = viewModel.outputSearchHistory.value[indexPath.row]
        shoppingSearchBar.text = selectedKeyword
        
        viewModel.inputSearchKeyword.value = selectedKeyword
        viewModel.inputSearchButtonClicked.value = ()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchKeywordTableViewCell.identifier) as! RecentSearchKeywordTableViewCell
        cell.resultLabel.text = viewModel.outputSearchHistory.value[indexPath.row]
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        
        return cell
    }
}
