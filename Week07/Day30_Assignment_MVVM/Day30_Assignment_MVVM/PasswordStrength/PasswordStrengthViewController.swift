//
//  PasswordStrengthViewController.swift
//  SeSAC8MVVMBasic
//
//  Created by Jack on 2/10/26.
//

import UIKit
import SnapKit

class PasswordStrengthViewController: UIViewController {

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 입력"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let strengthLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "0단계"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let viewModel = PasswordStrengthViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("viewDidLoad")
        configureUI()
        configureConstraints()
        configureActions()
        
        viewModel.outputStrengthLabel.bind {
//            print("viewModel.outputStrengthLabel.bind")
            self.strengthLabel.text = self.viewModel.outputStrengthLabel.value
        }
        
        viewModel.outputLevelLabel.bind {
//            print("viewModel.outputLevelLabel.bind")
            self.levelLabel.text = self.viewModel.outputLevelLabel.value
        }
    }
    
    @objc private func passwordChanged() {
//        print(#function)
        viewModel.inputPasswordField.value = passwordTextField.text!
    }
}

extension PasswordStrengthViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(passwordTextField)
        view.addSubview(strengthLabel)
        view.addSubview(levelLabel)
    }
    
    private func configureConstraints() {
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        strengthLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(strengthLabel.snp.bottom).offset(20)
            make.left.right.equalTo(passwordTextField)
        }
    }
    
    private func configureActions() {
        passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    }
}
