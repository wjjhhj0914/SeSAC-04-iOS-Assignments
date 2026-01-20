//
//  BoxOfficeViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

import SnapKit

class BoxOfficeViewController: UIViewController {
    
    let dimView = BoxOfficeDimmedBgView(bgImgUrl: "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    let topView = UIView()
    let searchTextField = BoxOfficeSearchTextField(placeholderText: "날짜를 입력하세요")
    let searchBtn = BoxOfficeSearchButton(titleStr: "검색")
    
    lazy var tableView = {
        let boxOfficeTableView = UITableView()
        
        boxOfficeTableView.backgroundColor = .clear
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        return boxOfficeTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell
        
        return cell
    }
}

extension BoxOfficeViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(dimView)
        view.addSubview(topView)
        topView.addSubview(searchTextField)
        topView.addSubview(searchBtn)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(searchBtn.snp.leading).offset(-12)
            make.height.equalTo(44)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        tableView.separatorStyle = .none
    }
}
