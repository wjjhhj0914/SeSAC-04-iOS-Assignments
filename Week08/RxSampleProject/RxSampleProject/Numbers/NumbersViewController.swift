//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/22/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NumbersViewController: BaseViewController {
    
    private let number1 = UITextField()
    private let number2 = UITextField()
    private let number3 = UITextField()
    private let plusLabel = UILabel()
    private let separator = UIView()
    private let result = UILabel()
    
    private let viewModel = NumbersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHierarchy() {
        [number1, number2, number3, result, plusLabel, separator].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        number1.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(150)
        }
        
        number2.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(number1.snp.bottom).offset(8)
            make.width.equalTo(150)
        }
        
        number3.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(number2.snp.bottom).offset(8)
            make.width.equalTo(150)
        }
        
        plusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(number3)
            make.trailing.equalTo(number3.snp.leading).offset(-8)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(8)
            make.leading.equalTo(plusLabel.snp.leading)
            make.trailing.equalTo(number3.snp.trailing)
            make.height.equalTo(1)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(8)
            make.trailing.equalTo(separator.snp.trailing)
            make.width.equalTo(150)
        }
    }
    
    override func configureView() {
        [number1, number2, number3].forEach {
            $0.placeholder = "number"
            $0.textAlignment = .right
            $0.keyboardType = .numberPad
        }
        
        plusLabel.text = "+"
        separator.backgroundColor = .lightGray
        result.textAlignment = .right
    }
    
    override func bind() {
        let input = NumbersViewModel.Input(number1: number1.rx.text.orEmpty, number2: number2.rx.text.orEmpty, number3: number3.rx.text.orEmpty)
        let output = viewModel.transform(input: input)
        
        output.resultText
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
    }
}
