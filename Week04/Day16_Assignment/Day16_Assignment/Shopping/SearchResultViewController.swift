//
//  SearchResultViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit

class SearchResultViewController: UIViewController {
    
    let totalCountLabel = UILabel()
    let sortedByAccuracyBtn = ShoppingSortButton(titleStr: "정확도")
    let sortedByDateBtn = ShoppingSortButton(titleStr: "날짜순")
    let sortedByHighPriceBtn = ShoppingSortButton(titleStr: "가격높은순")
    let sortedByLowPriceBtn = ShoppingSortButton(titleStr: "가격낮은순")
    let sortingStackView = UIStackView()
    
    lazy var collectionView = {
        let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultViewController.layout())
        
        resultCollectionView.backgroundColor = .black
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        return resultCollectionView
    }()

    var searchKeyword: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        navigationItem.title = searchKeyword
    }
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 16
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        return cell
    }
}

extension SearchResultViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(totalCountLabel)
        view.addSubview(sortingStackView)
        view.addSubview(collectionView)
        
        [sortedByAccuracyBtn, sortedByDateBtn, sortedByHighPriceBtn, sortedByLowPriceBtn].forEach {
            sortingStackView.addArrangedSubview($0)
        }
    }
    
    func configureLayout() {
        totalCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        sortingStackView.snp.makeConstraints { make in
            make.top.equalTo(totalCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sortingStackView.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        totalCountLabel.text = "13,235,449 개의 검색 결과"
        totalCountLabel.textColor = .green
        
        sortingStackView.axis = .horizontal
        sortingStackView.spacing = 8
        sortingStackView.distribution = .fillProportionally
    }
}
