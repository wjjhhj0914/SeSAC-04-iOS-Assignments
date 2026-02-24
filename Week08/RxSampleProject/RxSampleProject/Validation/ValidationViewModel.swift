//
//  ValidationViewModel.swift
//  RxSampleProject
//
//  Created by Hyojung Jang on 2/24/26.
//

import Foundation
import RxSwift
import RxCocoa

final class ValidationViewModel {
    let disposeBag = DisposeBag()
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    struct Input {
        let textInputTap: ControlEvent<Void>
        let usernameText: ControlProperty<String>
        let passwordText: ControlProperty<String>
    }
    
    struct Output {
        let isUsernameValid: BehaviorRelay<Bool>
        let isPasswordValid: BehaviorRelay<Bool>
        let isButtonEnabled: BehaviorRelay<Bool>
        let showAlert: PublishRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        let usernameValid = BehaviorRelay(value: false)
        let passwordValid = BehaviorRelay(value: false)
        let buttonEnabled = BehaviorRelay(value: false)
        let alert = PublishRelay<Bool>()
        
        input.usernameText
            .bind(with: self) { owner, text in
                let isValid = text.count >= owner.minimalUsernameLength
                usernameValid.accept(isValid)
            }
            .disposed(by: disposeBag)
        
        input.passwordText
            .bind(with: self) { owner, text in
                let isValid = text.count >= owner.minimalPasswordLength
                passwordValid.accept(isValid)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .bind(to: buttonEnabled)
            .disposed(by: disposeBag)
        
        input.textInputTap
            .bind(with: self) { owner, _ in
                print("버튼 클릭됨")
                alert.accept(true)
            }
            .disposed(by: disposeBag)
        
        
        return Output(isUsernameValid: usernameValid, isPasswordValid: passwordValid, isButtonEnabled: buttonEnabled, showAlert: alert)
    }
}
