//
//  ValidationViewController.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/22/26.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ValidationViewController: BaseViewController {
    
    private let usernameTitleLabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    
    private let usernameTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let usernameValidLabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "아이디는 최소 5자 이상이어야 합니다"
        return label
    }()
    
    private let passwordTitleLabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    
    private let passwordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordValidLabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.text = "비밀번호는 최소 5자 이상이어야 합니다"
        return label
    }()
    
    private let doSomethingButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Do something", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let viewModel = ValidationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureHierarchy() {
        [usernameTitleLabel, usernameTextField, usernameValidLabel, passwordTitleLabel, passwordTextField, passwordValidLabel, doSomethingButton].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        usernameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameTitleLabel)
            make.height.equalTo(44)
        }
        
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameTitleLabel)
        }
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameTitleLabel)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameTitleLabel)
            make.height.equalTo(44)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameTitleLabel)
        }
        
        doSomethingButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(usernameTitleLabel)
            make.height.equalTo(44)
        }
    }
    
    override func bind() {
        let input = ValidationViewModel.Input(
            textInputTap: doSomethingButton.rx.tap,
            usernameText: usernameTextField.rx.text.orEmpty,
            passwordText: passwordTextField.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.isUsernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isUsernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.isPasswordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.isButtonEnabled
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.showAlert
            .bind(with: self, onNext: { owner, _ in
                owner.alert(title: "알림", message: "환영합니다!")
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
