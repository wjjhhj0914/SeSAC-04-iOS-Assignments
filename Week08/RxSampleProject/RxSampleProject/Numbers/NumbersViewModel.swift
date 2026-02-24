//
//  NumbersViewModel.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/24/26.
//

import Foundation
import RxSwift
import RxCocoa

final class NumbersViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let number1: ControlProperty<String>
        let number2: ControlProperty<String>
        let number3: ControlProperty<String>
    }
    
    struct Output {
        let resultText: BehaviorRelay<String>
    }
    
    func transform(input: Input) -> Output {
        let result = BehaviorRelay(value: "0")
        
        Observable.combineLatest(input.number1, input.number2, input.number3) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { "\($0)" }
        .bind(to: result)
        .disposed(by: disposeBag)
        
        return Output(resultText: result)
    }
}
