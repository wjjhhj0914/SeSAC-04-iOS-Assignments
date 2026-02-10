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
     
    override func viewDidLoad() {
        super.viewDidLoad() 
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    @objc private func priceChanged() {
        print(#function)
        calculate()
    }
    
    @objc private func percentChanged() {
        print(#function)
        calculate()
    }
    
    private func calculate() {
        guard let priceText = priceTextField.text else {
            return
        }
        guard let percentText = percentTextField.text else {
            return
        }
        
        // 1) 빈 값
        guard !priceText.isEmpty, !percentText.isEmpty else {
            self.resultLabel.text = "가격과 할인율을 입력해주세요"
            self.view.backgroundColor = .systemOrange
            return
        }
        
        // 2) 숫자 변환
        guard let price = Int(priceText),
              let percent = Int(percentText) else {
            self.resultLabel.text = "숫자만 입력해주세요"
            self.view.backgroundColor = .systemOrange
            return
        }
        
        // 3) 범위 체크
        guard price > 0 else {
            self.resultLabel.text = "가격은 0보다 커야 합니다"
            self.view.backgroundColor = .systemOrange
            return
        }
        
        guard percent >= 0, percent <= 100 else {
            self.resultLabel.text = "할인율은 0~100 사이로 입력해주세요"
            self.view.backgroundColor = .systemOrange
            return
        }
        
        // 4) 계산
        let discount = price * percent / 100
        let finalPrice = price - discount
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let originalText = formatter.string(from: price as NSNumber)!
        let discountText = formatter.string(from: discount as NSNumber)!
        let finalText = formatter.string(from: finalPrice as NSNumber)!
        
        self.resultLabel.text = "₩\(originalText) → ₩\(discountText) 할인 → ₩\(finalText)"
        self.view.backgroundColor = .systemGreen
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
