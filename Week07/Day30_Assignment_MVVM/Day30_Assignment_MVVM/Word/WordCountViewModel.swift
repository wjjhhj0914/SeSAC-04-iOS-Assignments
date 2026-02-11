//
//  WordCountViewModel.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/11/26.
//

import Foundation

class WordCountViewModel {
    
    var inputTextView = "" {
        didSet {
            print("inputTextView", inputTextView)
            self.update()
        }
    }
    
    var outputCountLabel = "" {
        didSet {
            print("outputCountLabel", outputCountLabel)
            textAction?()
        }
    }
    
    var textAction: (() -> Void)?
    
    init() {
        print("viewModel Init")
        update()
    }
    
    private func update() {
        let count = inputTextView.count
        outputCountLabel = "현재까지 \(count)글자 작성중"
    }
}
