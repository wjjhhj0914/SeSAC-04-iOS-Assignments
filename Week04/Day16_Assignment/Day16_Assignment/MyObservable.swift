//
//  Observable.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation

class MyObservable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("MyObservable Didset", value)
            closure?(value)
        }
    }
    
    init(_ value: T) {
        print("MyObservable Init", value)
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print("MyObservable Bind Method")
        closure(value)
        self.closure = closure
    }
    
    func lazyBind(_ closure: @escaping (T) -> Void) {
        print("MyObservable Lazy Bind Method")
        self.closure = closure
    }
}
