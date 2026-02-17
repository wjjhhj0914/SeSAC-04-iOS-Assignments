//
//  ShoppingData.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import Foundation

struct ShoppingData: Decodable {
    let total: Int
    let display: Int
    let items: [ShoppingItems]
}

struct ShoppingItems: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
}
