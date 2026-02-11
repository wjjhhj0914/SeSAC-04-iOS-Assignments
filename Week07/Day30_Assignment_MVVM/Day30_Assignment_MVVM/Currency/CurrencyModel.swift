//
//  CurrencyModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import Foundation

class CurrencyModel {
    
    var inputField = Observable(value: "")
    
    var outputText = Observable(value: "")
    
    var textAction: (() -> Void)?
    
    init() {
        print("viewModel Init")
        
        inputField.bind {
            print(">>> inputField.bind")
            self.convert()
        }
    }
    
    private func convert() {
        if inputField.value.isEmpty {
            outputText.value = "환전 결과가 여기에 표시됩니다"
            return
        }
        
        guard let amount = Double(inputField.value) else {
            outputText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1450.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
