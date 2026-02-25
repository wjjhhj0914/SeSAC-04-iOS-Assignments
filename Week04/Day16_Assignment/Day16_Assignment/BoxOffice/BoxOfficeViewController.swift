//
//  BoxOfficeViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

import SnapKit
import Alamofire
import RxSwift
import RxCocoa

class BoxOfficeViewController: UIViewController {
    
    let dimView = BoxOfficeDimmedBgView(bgImgUrl: "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    let topView = UIView()
    let searchTextField = BoxOfficeSearchTextField(placeholderText: "날짜를 입력하세요")
    let searchBtn = BoxOfficeSearchButton(titleStr: "검색")
    
    lazy var tableView = {
        let boxOfficeTableView = UITableView()
        
        boxOfficeTableView.backgroundColor = .clear
        boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        return boxOfficeTableView
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = BoxOfficeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        bind()
    }
    
    func bind() {
        let searchTap = PublishRelay<Void>()
        
        searchBtn.rx.tap
            .bind(to: searchTap)
            .disposed(by: disposeBag)
        
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(to: searchTap)
            .disposed(by: disposeBag)
        
        let input = BoxOfficeViewModel.Input(
            searchTap: searchTap.asObservable(),
            searchText: searchTextField.rx.text.orEmpty.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.movieList
            .drive(tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as! BoxOfficeTableViewCell
                cell.boxOfficeRankLabel.text = element.rank
                cell.movieTitleLabel.text = element.movieNm
                cell.dateLabel.text = element.openDt
                return cell
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .bind(with: self) { owner, message in
                owner.alert(title: "에러", message: message)
            }
            .disposed(by: disposeBag)
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
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
        tableView.allowsSelection = false
    }
}
