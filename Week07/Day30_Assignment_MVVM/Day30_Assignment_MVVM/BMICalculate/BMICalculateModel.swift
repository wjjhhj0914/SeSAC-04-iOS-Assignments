//
//  BMICalculateModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/10/26.
//

import UIKit

class BMICalculateModel {
    // 처음에는 실행 X
    var heightInputField = Observable(value: "")
    var weightInputField = Observable(value: "")
    var outputText = Observable(value: "")
    var outputColour = Observable(value: UIColor.white)
    
    var textAction: (() -> Void)?
    
    init() {
        print("viewModel init")
        
        heightInputField.bind {
            print(">> heightInputField.playAction")
            self.calculateBmi()
        }
        
        weightInputField.bind {
            print(">> heightInputField.playAction")
            self.calculateBmi()
        }
    }
    
    private func calculateBmi() {
        // 1) 빈 값
        guard !heightInputField.value.isEmpty, !weightInputField.value.isEmpty else {
            outputText.value = "키와 몸무게를 입력해주세요"
            self.outputColour.value = .red.withAlphaComponent(0.3)
            return
        }
        
        // 2) 숫자 변환
        guard let height = Double(heightInputField.value),
              let weight = Double(weightInputField.value) else {
            outputText.value = "숫자만 입력해주세요"
            self.outputColour.value = .red.withAlphaComponent(0.3)
            return
        }
        
        // 3) 유효 범위
        guard height > 0, weight > 0 else {
            outputText.value = "0보다 큰 값을 입력해주세요"
            self.outputColour.value = .red.withAlphaComponent(0.3)
            return
        }
        
        // 4) BMI 계산
        let heightInMeter = height / 100
        let bmi = weight / (heightInMeter * heightInMeter)
        let bmiText = String(format: "%.1f", bmi)
        
        switch bmi {
        case ..<18.5:
            outputText.value = "BMI: \(bmiText) (저체중)"
            self.outputColour.value = .yellow.withAlphaComponent(0.3)
        case 18.5..<25:
            outputText.value = "BMI: \(bmiText) (정상) ✅"
            self.outputColour.value = .green.withAlphaComponent(0.3)
        case 25..<30:
            outputText.value = "BMI: \(bmiText) (과체중)"
            self.outputColour.value = .yellow.withAlphaComponent(0.3)
        default:
            outputText.value = "BMI: \(bmiText) (비만)"
            self.outputColour.value = .yellow.withAlphaComponent(0.3)
        }
    }
}
