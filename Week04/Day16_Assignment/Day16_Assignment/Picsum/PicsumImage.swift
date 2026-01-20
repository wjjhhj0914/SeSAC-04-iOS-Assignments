//
//  PicsumImage.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import Foundation

struct PicsumImage: Decodable {
    let author: String
    let width: Int
    let height: Int
    let download_url: String
}
