//
//  Observable.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation

class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("Observable Didset", value)
            closure?(value)
        }
    }
    
    init(_ value: T) {
        print("Observable Init", value)
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print("Observable Bind Method")
        closure(value)
        self.closure = closure
    }
    
    func lazyBind(_ closure: @escaping (T) -> Void) {
        print("Observable Lazy Bind Method")
        self.closure = closure
    }
}
