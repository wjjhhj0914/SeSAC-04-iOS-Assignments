//
//  Observable.swift
//  Day30_Assignment_MVVM
//
//  Created by Hyojung Jang on 2/10/26.
//

import Foundation

class Observable<T> {
    
    private var action: (() -> Void)?
    
    var value: T {
        didSet {
            print("Observable didSet", value)
            action?()
        }
    }
    
    init(value: T) {
        print("Observable Init")
        self.value = value
    }
    
    func bind(action: @escaping () -> Void) {
        action()
        self.action = action
    }
}
