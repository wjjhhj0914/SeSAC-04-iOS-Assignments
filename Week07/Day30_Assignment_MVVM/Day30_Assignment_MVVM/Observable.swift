//
//  Observable.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/10/26.
//

import Foundation

class Observable {
    
    private var action: (() -> Void)?
    
    var text: String {
        didSet {
            print("Observable didSet", text)
            action?()
        }
    }
    
    init(text: String) {
        print("Observable Init")
        self.text = text
    }
    
    func playAction(action: @escaping () -> Void) {
        print(#function, "START")
        action() // 초기값 지정 시 액션 동작을 원하는 경우
        self.action = action
        print(#function, "END")
    }
    
    func lazyAction(action: @escaping () -> Void) {
        print(#function, "START")
        self.action = action
        print(#function, "END")
    }
}
