//
//  HomeworkViewModel.swift
//  RxSubjectRelayProject
//
//  Created by Hyojung Jang on 2/24/26.
//

import Foundation
import RxSwift
import RxCocoa

struct SampleUser {
    let name: String
    let age: Int
}

final class HomeworkViewModel {
    let disposeBag = DisposeBag()
    
    private let userData = [
        SampleUser(name: "Steven", age: 20),
        SampleUser(name: "Mike", age: 21),
        SampleUser(name: "Emma", age: 22),
        SampleUser(name: "James", age: 23),
        SampleUser(name: "Lisa", age: 24),
        SampleUser(name: "John", age: 25),
        SampleUser(name: "Sarah", age: 26)
    ]
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String?>
        let cellSelected: ControlEvent<SampleUser>
    }
    
    struct Output {
        let userList: BehaviorRelay<[SampleUser]>
        let selectedUser: BehaviorRelay<[String]>
    }
    
    func transform(input: Input) -> Output {
        let userArray = BehaviorRelay(value: userData)
        let selectedArray = BehaviorRelay<[String]>(value: [])
        
        input.searchButtonTap
            .withLatestFrom(input.searchText.orEmpty)
            .filter { !$0.isEmpty }
            .bind(with: self) { owner, text in
                let newUser = SampleUser(name: text, age: 20)
                let currentValue = userArray.value
                userArray.accept([newUser] + currentValue)
            }
            .disposed(by: disposeBag)
        
        input.cellSelected
            .bind(with: self) { owner, user in
                let currentValue = selectedArray.value
                selectedArray.accept([user.name] + currentValue)
            }
            .disposed(by: disposeBag)
        
        return Output(userList: userArray, selectedUser: selectedArray)
    }
}
