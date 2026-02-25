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
        let errorMessage: PublishRelay<String>
    }
    
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let boxOfficeList = BehaviorRelay<[BoxOfficeData]>(value: [])
        let errorMessage = PublishRelay<String>()
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .map { text in
                let trimmedText = text.trimmingCharacters(in: .whitespaces)
                
                if trimmedText.count != 8 {
                    errorMessage.accept("yyyyMMdd 형식으로 입력해 주세요")
                    return ""
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMdd"
                
                if let userInputDate = formatter.date(from: trimmedText) {
                    let calendar = Calendar.current
                    let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())! // 어제 날짜 구하기
                    let year = calendar.component(.year, from: userInputDate) // 년도를 숫자만 뽑기
                    
                    if year >= 2004 && userInputDate <= yesterday { // 영진위 2004년도부터 데이터 주기 때문
                        print("검증 완")
                        return trimmedText
                    } else {
                        errorMessage.accept("박스오피스는 2004년부터 어제 날짜까지만 검색 가능합니다")
                        return ""
                    }
                } else {
                    errorMessage.accept("올바른 날짜를 입력해 주세요!")
                    return ""
                }
            }
            .filter { $0 != "" } // 빈 값은 통과시키지 않고
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
        
        return Output(movieList: boxOfficeList.asDriver(), errorMessage: errorMessage)
    }
}
