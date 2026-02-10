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
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    @objc private func passwordChanged() {
        print(#function)
        guard let pw = passwordTextField.text else {
            return
        }
        
        // 1) 빈 값
        guard !pw.isEmpty else {
            strengthLabel.text = "비밀번호를 입력해주세요"
            levelLabel.text = "0단계"
            return
        }
        
        // 2) 조건 체크
        var score = 0
        
        if pw.count >= 6 { score += 1 }   // 길이
        if pw.count >= 10 { score += 1 }   // 긴 길이
        
        let hasNumber = pw.contains(where: { $0.isNumber })
        if hasNumber { score += 1 }         // 숫자 포함
        
        let hasSpecial = pw.contains(where: { "!@#$%^&*".contains($0) })
        if hasSpecial { score += 1 }        // 특수문자 포함
        
        // 3) 단계별 판정
        switch score {
        case 0:
            strengthLabel.text = "⚠️ 너무 짧습니다"
            levelLabel.text = "0단계"
        case 1:
            strengthLabel.text = "🔴 약함"
            levelLabel.text = "1단계"
        case 2:
            strengthLabel.text = "🟡 보통"
            levelLabel.text = "2단계"
        case 3:
            strengthLabel.text = "🟢 강함"
            levelLabel.text = "3단계"
        default:
            strengthLabel.text = "💪 매우 강함"
            levelLabel.text = "3단계"
        }
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
