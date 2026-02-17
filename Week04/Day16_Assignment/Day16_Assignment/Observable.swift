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
    
    init(value: T) {
        print("Observable Init", value)
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
