//
//  PasswordStrengthViewModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import Foundation

class PasswordStrengthViewModel {
    
    var inputPasswordField = "" {
        didSet {
            print("inputPasswordField", inputPasswordField)
        }
    }
    
    var outputStrengthLabel = "" {
        didSet {
            print("outputStrengthLabel", outputStrengthLabel)
        }
    }
    
    var outputLevelLabel = "" {
        didSet {
            print("outputLevelLabel", outputLevelLabel)
        }
    }
    
    var textAction: (() -> Void)?
    
    private func validate() {
        
        // 1) 빈 값
        guard !inputPasswordField.isEmpty else {
            outputStrengthLabel = "비밀번호를 입력해주세요"
            outputLevelLabel = "0단계"
            return
        }
        
        // 2) 조건 체크
        var score = 0
        
        if inputPasswordField.count >= 6 { score += 1 }   // 길이
        if inputPasswordField.count >= 10 { score += 1 }   // 긴 길이
        
        let hasNumber = inputPasswordField.contains(where: { $0.isNumber })
        if hasNumber { score += 1 }         // 숫자 포함
        
        let hasSpecial = inputPasswordField.contains(where: { "!@#$%^&*".contains($0) })
        if hasSpecial { score += 1 }        // 특수문자 포함
        
        // 3) 단계별 판정
        switch score {
        case 0:
            outputStrengthLabel = "⚠️ 너무 짧습니다"
            outputLevelLabel = "0단계"
        case 1:
            outputStrengthLabel = "🔴 약함"
            outputLevelLabel = "1단계"
        case 2:
            outputStrengthLabel = "🟡 보통"
            outputLevelLabel = "2단계"
        case 3:
            outputStrengthLabel = "🟢 강함"
            outputLevelLabel = "3단계"
        default:
            outputStrengthLabel = "💪 매우 강함"
            outputLevelLabel = "3단계"
        }
    }
}
