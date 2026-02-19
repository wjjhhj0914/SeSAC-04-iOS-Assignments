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
        let viewDidLoadTrigger = Observable(())
        let sortButtonClicked = Observable("sim")
    }
    
    struct Output {
        let shoppingList: Observable<[ShoppingItems]> = Observable([])
        let totalCountLabel = Observable("")
        let navigationTitle = Observable("")
        let scrollToTop = Observable(())
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
            print("inputViewDidLoadTrigger.bind")
            self.output.navigationTitle.value = self.searchKeyword
            self.callRequest(sortingType: "sim")
        }
        
        input.sortButtonClicked.bind { sortingType in
            print("inputSortButtonClicked.bind")
            self.callRequest(sortingType: sortingType)
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
