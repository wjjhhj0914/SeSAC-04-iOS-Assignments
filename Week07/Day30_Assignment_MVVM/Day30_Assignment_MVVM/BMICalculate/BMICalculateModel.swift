//
//  BMICalculateModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/10/26.
//

import Foundation

class BMICalculateModel {
    // 처음에는 실행 X
    var heightInputField = "" {
        didSet {
            print("heightInputField", heightInputField)
            calculateBmi()
        }
    }
    
    var weightInputField = "" {
        didSet {
            print("weightInputField", weightInputField)
            calculateBmi()
        }
    }
    
    var outputText = "" {
        didSet {
            print("outputText", outputText)
            textAction?()
        }
    }
    
    var textAction: (() -> Void)?
    
    init() {
        print("viewModel init")
        calculateBmi()
    }
    
    private func calculateBmi() {
        // 1) 빈 값
        guard !heightInputField.isEmpty, !weightInputField.isEmpty else {
            outputText = "키와 몸무게를 입력해주세요"
//            self.resultLabel.backgroundColor = .red.withAlphaComponent(0.3)
            return
        }
        
        // 2) 숫자 변환
        guard let height = Double(heightInputField),
              let weight = Double(weightInputField) else {
            outputText = "숫자만 입력해주세요"
//            self.resultLabel.backgroundColor = .red.withAlphaComponent(0.3)
            return
        }
        
        // 3) 유효 범위
        guard height > 0, weight > 0 else {
            outputText = "0보다 큰 값을 입력해주세요"
//            self.resultLabel.backgroundColor = .red.withAlphaComponent(0.3)
            return
        }
        
        // 4) BMI 계산
        let heightInMeter = height / 100
        let bmi = weight / (heightInMeter * heightInMeter)
        let bmiText = String(format: "%.1f", bmi)
        
        switch bmi {
        case ..<18.5:
            outputText = "BMI: \(bmiText) (저체중)"
//            self.resultLabel.backgroundColor = .yellow.withAlphaComponent(0.3)
        case 18.5..<25:
            outputText = "BMI: \(bmiText) (정상) ✅"
//            self.resultLabel.backgroundColor = .green.withAlphaComponent(0.3)
        case 25..<30:
            outputText = "BMI: \(bmiText) (과체중)"
//            self.resultLabel.backgroundColor = .yellow.withAlphaComponent(0.3)
        default:
            outputText = "BMI: \(bmiText) (비만)"
//            self.resultLabel.backgroundColor = .yellow.withAlphaComponent(0.3)
        }
    }
}
