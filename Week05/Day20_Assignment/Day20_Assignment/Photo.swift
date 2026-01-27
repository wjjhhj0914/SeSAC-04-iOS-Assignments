//
//  Photo.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/26/26.
//

import Foundation

// 사진 검색 결과 전체를 담는 식판
struct PhotoSearchResponse: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Photo]
}

// 사진 한 장 식판
struct Photo: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let urls: PhotoUrl
    let likes: Int
    let user: PhotoUser
}

// 사진 이미지 링크
struct PhotoUrl: Decodable {
    let thumb: String
    let small: String
    let full: String
}

// 사진 작가
struct PhotoUser: Decodable {
    let name: String
}
