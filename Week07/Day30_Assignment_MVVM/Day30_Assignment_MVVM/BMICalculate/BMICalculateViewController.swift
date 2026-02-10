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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        configureActions()
    }
    
    @objc private func heightChanged() {
        print(#function)
        calculate()
    }
    
    @objc private func weightChanged() {
        print(#function)
        calculate()
    }
    
    private func calculate() {
        guard let heightText = heightTextField.text, let weightText = weightTextField.text else {
            return
            
        }
        
        // 1) 빈 값
        guard !heightText.isEmpty, !weightText.isEmpty else {
            self.resultLabel.text = "키와 몸무게를 입력해주세요"
            self.resultLabel.backgroundColor = .red.withAlphaComponent(0.3)
            return
        }
        
        // 2) 숫자 변환
        guard let height = Double(heightText),
              let weight = Double(weightText) else {
            self.resultLabel.text = "숫자만 입력해주세요"
            self.resultLabel.backgroundColor = .red.withAlphaComponent(0.3)
            return
        }
        
        // 3) 유효 범위
        guard height > 0, weight > 0 else {
            self.resultLabel.text = "0보다 큰 값을 입력해주세요"
            self.resultLabel.backgroundColor = .red.withAlphaComponent(0.3)
            return
        }
        
        // 4) BMI 계산
        let heightInMeter = height / 100
        let bmi = weight / (heightInMeter * heightInMeter)
        let bmiText = String(format: "%.1f", bmi)
        
        switch bmi {
        case ..<18.5:
            self.resultLabel.text = "BMI: \(bmiText) (저체중)"
            self.resultLabel.backgroundColor = .yellow.withAlphaComponent(0.3)
        case 18.5..<25:
            self.resultLabel.text = "BMI: \(bmiText) (정상) ✅"
            self.resultLabel.backgroundColor = .green.withAlphaComponent(0.3)
        case 25..<30:
            self.resultLabel.text = "BMI: \(bmiText) (과체중)"
            self.resultLabel.backgroundColor = .yellow.withAlphaComponent(0.3)
        default:
            self.resultLabel.text = "BMI: \(bmiText) (비만)"
            self.resultLabel.backgroundColor = .yellow.withAlphaComponent(0.3)
        }
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
