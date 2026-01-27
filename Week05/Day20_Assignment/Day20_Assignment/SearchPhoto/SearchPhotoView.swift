//
//  SearchPhotoView.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit
import SnapKit

class SearchPhotoView: BaseView {
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchPhotoView.layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.65)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        searchBar.searchBarStyle = .minimal
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
}
