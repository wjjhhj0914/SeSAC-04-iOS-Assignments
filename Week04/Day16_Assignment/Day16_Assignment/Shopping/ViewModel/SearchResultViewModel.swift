//
//  SearchResultViewModel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation

final class SearchResultViewModel: BaseViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        let viewDidLoadTrigger = MyObservable(())
        let sortButtonClicked = MyObservable("sim")
        let likeButtonClicked: MyObservable<Int?> = MyObservable(nil)
    }
    
    struct Output {
        let shoppingList: MyObservable<[ShoppingItems]> = MyObservable([])
        let totalCountLabel = MyObservable("")
        let navigationTitle = MyObservable("")
        let scrollToTop = MyObservable(())
    }
    
    var searchKeyword: String = ""
    
    init() {
        print("SearchResultViewModel Init")
        
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.viewDidLoadTrigger.bind {
            print("input.viewDidLoadTrigger.bind")
            self.output.navigationTitle.value = self.searchKeyword
            self.callRequest(sortingType: "sim")
        }
        
        input.sortButtonClicked.bind { sortingType in
            print("input.sortButtonClicked.bind")
            self.callRequest(sortingType: sortingType)
        }
        
        input.likeButtonClicked.bind { index in
            print("input.likeButtonClicked.bind")
            if let value = index {
                let productId = self.output.shoppingList.value[value].productId
                
                var currentLikes = UserDefaultManager.likedProduct
                
                if currentLikes.contains(productId) {
                    currentLikes = currentLikes.filter { $0 != productId}
                } else {
                    currentLikes.append(productId)
                }
                
                UserDefaultManager.likedProduct = currentLikes
                self.output.shoppingList.value = self.output.shoppingList.value
            }
        }
    }
    
    private func callRequest(sortingType: String) {
        print(">")
        ShoppingManager.shared.callRequest(query: searchKeyword, sort: sortingType) { value in
            self.output.shoppingList.value = value.items
            self.output.totalCountLabel.value = "\(value.total.formatted())개의 검색 결과"
            self.output.scrollToTop.value = ()
        }
    }
}
