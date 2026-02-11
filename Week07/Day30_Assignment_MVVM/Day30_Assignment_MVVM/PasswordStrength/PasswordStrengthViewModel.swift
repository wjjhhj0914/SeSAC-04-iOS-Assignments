//
//  PasswordStrengthViewModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import Foundation

class PasswordStrengthViewModel {
    
    var inputPasswordField = Observable(value: "")
    var outputStrengthLabel = Observable(value: "")
    var outputLevelLabel = Observable(value: "")
    
    var textAction: (() -> Void)?
    
    init() {
        print("viewModel Init")
        
        inputPasswordField.bind {
            print("inputPasswordField.bind")
            self.validate()
        }
    }
    
    private func validate() {
        
        // 1) 빈 값
        guard !inputPasswordField.value.isEmpty else {
            outputStrengthLabel.value = "비밀번호를 입력해주세요"
            outputLevelLabel.value = "0단계"
            return
        }
        
        // 2) 조건 체크
        var score = 0
        
        if inputPasswordField.value.count >= 6 { score += 1 }   // 길이
        if inputPasswordField.value.count >= 10 { score += 1 }   // 긴 길이
        
        let hasNumber = inputPasswordField.value.contains(where: { $0.isNumber })
        if hasNumber { score += 1 }         // 숫자 포함
        
        let hasSpecial = inputPasswordField.value.contains(where: { "!@#$%^&*".contains($0) })
        if hasSpecial { score += 1 }        // 특수문자 포함
        
        // 3) 단계별 판정
        switch score {
        case 0:
            outputStrengthLabel.value = "⚠️ 너무 짧습니다"
            outputLevelLabel.value = "0단계"
        case 1:
            outputStrengthLabel.value = "🔴 약함"
            outputLevelLabel.value = "1단계"
        case 2:
            outputStrengthLabel.value = "🟡 보통"
            outputLevelLabel.value = "2단계"
        case 3:
            outputStrengthLabel.value = "🟢 강함"
            outputLevelLabel.value = "3단계"
        default:
            outputStrengthLabel.value = "💪 매우 강함"
            outputLevelLabel.value = "3단계"
        }
    }
}
