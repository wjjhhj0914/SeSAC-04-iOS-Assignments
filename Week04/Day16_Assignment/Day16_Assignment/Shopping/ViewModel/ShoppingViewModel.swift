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
    let inputDeleteButtonClicked: Observable<Int?> = Observable(nil)
    let inputDeleteAllButtonClicked = Observable(())
    
    let outputSearchHistory: Observable<[String]> = Observable([])
    let outputValidSearchKeyword: Observable<String?> = Observable(nil)
    let outputAlertMessage: Observable<String?> = Observable(nil)
    
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
        
        inputDeleteButtonClicked.bind { index in
            print("inputDeleteButtonClicked.bind")
            if let value = index {
                self.removeKeyword(index: value)
            }
        }
        
        inputDeleteAllButtonClicked.bind {
            print("inputDeleteAllButtonClicked.bind")
            UserDefaultManager.searchHistory = []
            self.outputSearchHistory.value = []
        }
    }
    
    private func search() {
        let userInputText = inputSearchKeyword.value
        
        if userInputText.count < 2 {
            outputAlertMessage.value = "2글자 이상 입력해주세요"
        } else {
            let currentHistory = UserDefaultManager.searchHistory
            var userSearchedList: [String] = [userInputText]
            
            for searchedItem in currentHistory {
                if searchedItem != userInputText {
                    userSearchedList.append(searchedItem)
                }
            }
            
            UserDefaultManager.searchHistory = userSearchedList
            outputSearchHistory.value = userSearchedList
            outputValidSearchKeyword.value = userInputText
        }
    }
    
    private func removeKeyword(index: Int) {
        var currentKeyword = outputSearchHistory.value
        currentKeyword.remove(at: index)
        UserDefaultManager.searchHistory = currentKeyword
        outputSearchHistory.value = currentKeyword
    }
}
