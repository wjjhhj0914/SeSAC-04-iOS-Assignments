//
//  BaseViewModel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/19/26.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
