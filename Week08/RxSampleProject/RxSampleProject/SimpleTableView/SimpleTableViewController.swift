//
//  SimpleTableViewController.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/22/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimpleTableViewController: BaseViewController {
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
    }
    
    override func bind() {
        let items = Observable.just((0 ..< 20).map { "\($0)" })
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: SimpleTableViewCell.identifier, cellType: SimpleTableViewCell.self)) { row, element, cell in
                cell.simpleLabel.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { value in
                self.alert(title: "알림", message: "Tapped \(value)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                self.alert(title: "알림", message: "Tapped Detail @ \(indexPath.section), \(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
