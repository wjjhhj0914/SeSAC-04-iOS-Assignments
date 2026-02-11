//
//  WordCountViewModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import Foundation

class WordCountViewModel {
    
    var inputTextView = Observable(value: "")
    var outputCountLabel = Observable(value: "")
    
    var textAction: (() -> Void)?
    
    init() {
        print("viewModel Init")
        
        inputTextView.bind {
            print("inputTextView.bind")
            self.update()
        }
    }
    
    private func update() {
        let count = inputTextView.value.count
        outputCountLabel.value = "현재까지 \(count)글자 작성중"
    }
}
