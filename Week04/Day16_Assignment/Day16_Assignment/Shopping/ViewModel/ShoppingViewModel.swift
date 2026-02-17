//
//  ShoppingViewModel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation

final class ShoppingViewModel {
    
    let inputViewDidLoadTrigger = Observable(())
    let inputSearchKeyword = Observable("")
    let inputSearchButtonClicked = Observable(())
    
    let outputSearchHistory: Observable<[String]> = Observable([])
    let outputValidSearchKeyword = Observable<String?>(nil)
    let outputAlertMessage = Observable<String?>(nil)
    
    init () {
        print("ShoppingViewModel Init")
        
        inputViewDidLoadTrigger.bind {
            print("inputViewDidLoadTrigger 신호 받음")
            self.outputSearchHistory.value = UserDefaultManager.searchHistory
        }
        
        inputSearchButtonClicked.bind {
            print("inputSearchButtonClicked")
            self.search()
        }
    }
    
    private func search() {
        let userInputText = inputSearchKeyword.value
        
        if userInputText.count < 2 {
            outputAlertMessage.value = "2글자 이상 입력해주세요"
        } else {
            outputValidSearchKeyword.value = userInputText
        }
    }
}
