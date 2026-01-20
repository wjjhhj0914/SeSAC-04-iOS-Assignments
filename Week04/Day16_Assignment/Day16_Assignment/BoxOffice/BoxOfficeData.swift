//
//  BoxOfficeData.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import Foundation

struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [BoxOfficeData]
}

struct BoxOfficeData: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
