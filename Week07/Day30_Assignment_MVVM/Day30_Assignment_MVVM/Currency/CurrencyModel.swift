//
//  CurrencyModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import Foundation

class CurrencyModel {
    
    var inputField = "" {
        didSet {
            print("inputField", inputField)
            convert()
        }
    }
    
    var outputText = "" {
        didSet {
            print("outputText", outputText)
            textAction?()
        }
    }
    
    var textAction: (() -> Void)?
    
    private func convert() {
        guard let amount = Double(inputField) else {
            outputText = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1450.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        outputText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
