//
//  DiscountViewController.swift
//  SeSAC8MVVMBasic
//
//  Created by Jack on 2/10/26.
//

import UIKit
import SnapKit

class DiscountViewController: UIViewController {

    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "가격 입력 (원)"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let percentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "할인율 입력 (%)"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "가격과 할인율을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let viewModel = DiscountViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        configureUI()
        configureConstraints()
        configureActions()
        
        viewModel.outputText.bind {
            print("viewModel textAction")
            self.resultLabel.text = self.viewModel.outputText.value
        }
    }
    
    @objc private func priceChanged() {
        print(#function)
        viewModel.inputPriceTextField.value = priceTextField.text!
        
        viewModel.outputColour.bind {
            print("viewModel outputColour.bind")
            self.view.backgroundColor = self.viewModel.outputColour.value
        }
    }
    
    @objc private func percentChanged() {
        print(#function)
        viewModel.inputPercentageTextField.value = percentTextField.text!
    }
}

extension DiscountViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(priceTextField)
        view.addSubview(percentTextField)
        view.addSubview(resultLabel)
    }
    
    private func configureConstraints() {
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        percentTextField.snp.makeConstraints { make in
            make.top.equalTo(priceTextField.snp.bottom).offset(16)
            make.left.right.equalTo(priceTextField)
            make.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(percentTextField.snp.bottom).offset(20)
            make.left.right.equalTo(priceTextField)
        }
    }
    
    private func configureActions() {
        priceTextField.addTarget(self, action: #selector(priceChanged), for: .editingChanged)
        percentTextField.addTarget(self, action: #selector(percentChanged), for: .editingChanged)
    }
}
