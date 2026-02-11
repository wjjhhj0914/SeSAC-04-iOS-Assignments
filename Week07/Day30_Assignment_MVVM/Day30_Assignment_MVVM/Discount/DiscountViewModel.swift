//
//  DiscountViewModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import UIKit

class DiscountViewModel {
    
    var inputPriceTextField = Observable(value: "")
    var inputPercentageTextField = Observable(value: "")
    var outputText = Observable(value: "")
    var outputColour = Observable(value: UIColor.white)
    
    var textAction: (() -> Void)?
    
    init() {
//        print("viewModel Init")
        
        inputPriceTextField.bind {
//            print(">>> inputPriceTextField.bind")
            self.calculate()
        }
        
        inputPercentageTextField.bind {
//            print(">>> inputPercentageTextField.bind")
            self.calculate()
        }
    }
    
    private func calculate() {
        
        // 1) 빈 값
        guard !inputPriceTextField.value.isEmpty, !inputPercentageTextField.value.isEmpty else {
            self.outputText.value = "가격과 할인율을 입력해주세요"
            self.outputColour.value = .systemOrange
            return
        }
        
        // 2) 숫자 변환
        guard let price = Int(inputPriceTextField.value),
              let percent = Int(inputPercentageTextField.value) else {
            self.outputText.value = "숫자만 입력해주세요"
            self.outputColour.value = .systemOrange
            return
        }
        
        // 3) 범위 체크
        guard price > 0 else {
            self.outputText.value = "가격은 0보다 커야 합니다"
            self.outputColour.value = .systemOrange
            return
        }
        
        guard percent >= 0, percent <= 100 else {
            self.outputText.value = "할인율은 0~100 사이로 입력해주세요"
            self.outputColour.value = .systemOrange
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
        
        self.outputText.value = "₩\(originalText) → ₩\(discountText) 할인 → ₩\(finalText)"
        self.outputColour.value = .systemGreen
    }
}
