//
//  CustomObservable.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/25/26.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class CustomObservable {
    static func callRequest(targetDt: String) -> Observable<[BoxOfficeData]> {
        return Observable<[BoxOfficeData]>.create { observer in
            let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.KOFIC)&targetDt=\(targetDt)"
            AF.request(url, method: .get).responseDecodable(of: BoxOfficeResponse.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value.boxOfficeResult.dailyBoxOfficeList)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
