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
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchPhotoView.layout())
    let noResultsLabel = UILabel()
    
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
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(collectionView)
        addSubview(noResultsLabel)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        noResultsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configureView() {
        searchBar.placeholder = "키워드 검색"
        searchBar.searchBarStyle = .minimal
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        collectionView.isHidden = true
        noResultsLabel.isHidden = false
        noResultsLabel.text = "사진을 검색해 보세요."
        noResultsLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        stackView.spacing = 10
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
