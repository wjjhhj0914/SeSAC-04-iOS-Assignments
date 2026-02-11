//
//  BMICalculateViewController.swift
//  SeSAC8MVVMBasic
//
//  Created by Jack on 2/10/26.
//

import UIKit
import SnapKit

class BMIViewController: UIViewController {
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키 입력 (cm)"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게 입력 (kg)"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "키와 몸무게를 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let viewModel = BMICalculateModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("viewController viewDidLoad")
        
        viewModel.outputText.bind {
//            print("viewModel outputText playAction")
            self.resultLabel.text = self.viewModel.outputText.value
        }
        
        viewModel.outputColour.bind {
            self.resultLabel.backgroundColor = self.viewModel.outputColour.value
        }
        
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    @objc private func heightChanged() {
//        print(#function)
        calculate()
    }
    
    @objc private func weightChanged() {
//        print(#function)
        calculate()
    }
    
    private func calculate() {
//        print(#function)
        viewModel.heightInputField.value = heightTextField.text!
        viewModel.weightInputField.value = weightTextField.text!
    }
}

extension BMIViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultLabel)
    }
    
    private func configureConstraints() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(16)
            make.left.right.equalTo(heightTextField)
            make.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
            make.left.right.equalTo(heightTextField)
        }
    }
    
    private func configureActions() {
        heightTextField.addTarget(self, action: #selector(heightChanged), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(weightChanged), for: .editingChanged)
    }
}
