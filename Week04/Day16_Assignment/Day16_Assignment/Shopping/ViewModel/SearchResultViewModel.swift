//
//  SearchResultViewModel.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation

final class SearchResultViewModel {
    
    let inputViewDidLoadTrigger = Observable(())
    let inputSortButtonClicked = Observable("sim")
    
    let outputShoppingList: Observable<[ShoppingItems]> = Observable([])
    let outputTotalCountLabel = Observable("")
    let outputNavigationTitle = Observable("")
    let outputScrollToTop = Observable(())
    
    var searchKeyword: String = ""
    
    init() {
        print("SearchResultViewModel Init")
        
        inputViewDidLoadTrigger.bind {
            print("inputViewDidLoadTrigger.bind")
            self.outputNavigationTitle.value = self.searchKeyword
            self.callRequest(sortingType: "sim")
        }
        
        inputSortButtonClicked.bind { sortingType in
            print("inputSortButtonClicked.bind")
            self.callRequest(sortingType: sortingType)
        }
    }
    
    private func callRequest(sortingType: String) {
        print(">")
        ShoppingManager.shared.callRequest(query: searchKeyword, sort: sortingType) { value in
            self.outputShoppingList.value = value.items
            self.outputTotalCountLabel.value = "\(value.total.formatted())개의 검색 결과"
            self.outputScrollToTop.value = ()
        }
    }
}
