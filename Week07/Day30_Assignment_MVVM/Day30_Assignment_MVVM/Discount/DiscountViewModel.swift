//
//  DiscountViewModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import UIKit

class DiscountViewModel {
    
    var inputPriceTextField = "" {
        didSet {
            print("inputPriceTextField", inputPriceTextField)
            calculate()
        }
    }
    
    var inputPercentageTextField = "" {
        didSet {
            print("inputPercentageTextField", inputPercentageTextField)
            calculate()
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
        print("viewModel Init")
        calculate()
    }
    
    private func calculate() {
        
        // 1) 빈 값
        guard !inputPriceTextField.isEmpty, !inputPercentageTextField.isEmpty else {
            self.outputText = "가격과 할인율을 입력해주세요"
//            self.view.backgroundColor = .systemOrange
            return
        }
        
        // 2) 숫자 변환
        guard let price = Int(inputPriceTextField),
              let percent = Int(inputPercentageTextField) else {
            self.outputText = "숫자만 입력해주세요"
//            self.view.backgroundColor = .systemOrange
            return
        }
        
        // 3) 범위 체크
        guard price > 0 else {
            self.outputText = "가격은 0보다 커야 합니다"
//            self.view.backgroundColor = .systemOrange
            return
        }
        
        guard percent >= 0, percent <= 100 else {
            self.outputText = "할인율은 0~100 사이로 입력해주세요"
//            self.view.backgroundColor = .systemOrange
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
        
        self.outputText = "₩\(originalText) → ₩\(discountText) 할인 → ₩\(finalText)"
//        self.view.backgroundColor = .systemGreen
    }
}
