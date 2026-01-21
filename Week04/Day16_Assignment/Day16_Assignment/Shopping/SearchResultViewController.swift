//
//  SearchResultViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var searchKeyword: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        print("검색어: \(searchKeyword ?? "없음")")
        
        navigationItem.title = searchKeyword
    }
}
