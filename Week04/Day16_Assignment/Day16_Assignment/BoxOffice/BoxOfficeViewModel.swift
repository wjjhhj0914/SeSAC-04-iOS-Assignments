//
//  BoxOfficeViewModel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/25/26.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel {
    struct Input {
        let searchTap: Observable<Void>
        let searchText: Observable<String>
    }
    
    struct Output {
        let movieList: Driver<[BoxOfficeData]>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let boxOfficeList = BehaviorRelay<[BoxOfficeData]>(value: [])
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.callRequest(targetDt: text)
                    .catch { _ in
                        return Observable.never()
                    }
            }
            .subscribe(with: self) { owner, movie in
                boxOfficeList.accept(movie)
                print("onNext")
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(movieList: boxOfficeList.asDriver())
    }
}
