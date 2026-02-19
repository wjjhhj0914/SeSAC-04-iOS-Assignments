//
//  UserDefaultManager.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/22/26.
//

import Foundation

enum UDKey {
    static let searchHistory = "searchHistory"
}

struct UserDefaultManager {
    
    static var searchHistory: [String] {
        get {
            let history = UserDefaults.standard.stringArray(forKey: UDKey.searchHistory) ?? []
            return history
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UDKey.searchHistory)
        }
    }
    
    static var likedProduct: [String] {
        get {
            let like = UserDefaults.standard.stringArray(forKey: "likedProduct") ?? []
            return like
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "likedProduct")
        }
    }
}
