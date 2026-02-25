//
//  ShoppingViewModel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation

final class ShoppingViewModel: BaseViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        let viewDidLoadTrigger = MyObservable(())
        let searchKeyword = MyObservable("")
        let searchButtonClicked = MyObservable(())
        let deleteButtonClicked: MyObservable<Int?> = MyObservable(nil)
        let deleteAllButtonClicked = MyObservable(())
    }
    
    struct Output {
        let searchHistory: MyObservable<[String]> = MyObservable([])
        let validSearchKeyword: MyObservable<String?> = MyObservable(nil)
        let alertMessage: MyObservable<String?> = MyObservable(nil)
    }
    
    init () {
        print("ShoppingViewModel Init")
        
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.viewDidLoadTrigger.bind {
            print("inputViewDidLoadTrigger 신호 받음")
            self.output.searchHistory.value = UserDefaultManager.searchHistory
        }
        
        input.searchButtonClicked.lazyBind {
            print("inputSearchButtonClicked")
            self.search()
        }
        
        input.deleteButtonClicked.lazyBind { index in
            print("inputDeleteButtonClicked.bind")
            if let value = index {
                self.removeKeyword(index: value)
            }
        }
        
        input.deleteAllButtonClicked.lazyBind {
            print("inputDeleteAllButtonClicked.bind")
            UserDefaultManager.searchHistory = []
            self.output.searchHistory.value = []
        }
    }
    
    private func search() {
        let userInputText = input.searchKeyword.value
        
        if userInputText.count < 2 {
            output.alertMessage.value = "2글자 이상 입력해주세요"
        } else {
            let currentHistory = UserDefaultManager.searchHistory
            var userSearchedList: [String] = [userInputText]
            
            for searchedItem in currentHistory {
                if searchedItem != userInputText {
                    userSearchedList.append(searchedItem)
                }
            }
            
            UserDefaultManager.searchHistory = userSearchedList
            output.searchHistory.value = userSearchedList
            output.validSearchKeyword.value = userInputText
        }
    }
    
    private func removeKeyword(index: Int) {
        var currentKeyword = output.searchHistory.value
        currentKeyword.remove(at: index)
        UserDefaultManager.searchHistory = currentKeyword
        output.searchHistory.value = currentKeyword
    }
}
