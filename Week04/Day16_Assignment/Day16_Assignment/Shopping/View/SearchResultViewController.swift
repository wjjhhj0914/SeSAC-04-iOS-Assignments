//
//  SearchResultViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/21/26.
//

import UIKit

import SnapKit
import Alamofire
import Kingfisher

class SearchResultViewController: BaseViewController {
    
    private let totalCountLabel = UILabel()
    private let sortedByAccuracyBtn = ShoppingSortButton(titleStr: "정확도")
    private let sortedByDateBtn = ShoppingSortButton(titleStr: "날짜순")
    private let sortedByHighPriceBtn = ShoppingSortButton(titleStr: "가격높은순")
    private let sortedByLowPriceBtn = ShoppingSortButton(titleStr: "가격낮은순")
    private let sortingStackView = UIStackView()
    private lazy var collectionView = {
        let resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: SearchResultViewController.layout())
        
        resultCollectionView.backgroundColor = .black
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        
        return resultCollectionView
    }()
    
    static private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 16
        let width = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.65)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
    
    let viewModel = SearchResultViewModel()

    var searchKeyword: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureButtonActions()
        
        viewModel.searchKeyword = searchKeyword ?? ""
        
        print("SearchResultViewController ViewDidLoad")
        sortedByAccuracyBtn.isSelected = true
        
        viewModel.output.navigationTitle.bind { value in
            print("viewModel.outputNavigationTitle.bind")
            self.navigationItem.title = value
        }
        
        viewModel.output.shoppingList.bind { _ in
            print("viewModel.outputShoppingList.bind")
            self.collectionView.reloadData()
        }
        
        viewModel.output.totalCountLabel.bind { value in
            print("viewModel.outputTotalCountLabel.bind")
            self.totalCountLabel.text = value
        }
        
        viewModel.output.scrollToTop.bind { _ in
            print("viewModel.outputScrollToTop.bind")
            if !self.viewModel.output.shoppingList.value.isEmpty {
                self.collectionView.setContentOffset(.zero, animated: true)
            }
        }
        
        viewModel.input.viewDidLoadTrigger.value = ()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(totalCountLabel)
        view.addSubview(sortingStackView)
        view.addSubview(collectionView)
        sortingStackView.addArrangedSubview(sortedByAccuracyBtn)
        sortingStackView.addArrangedSubview(sortedByDateBtn)
        sortingStackView.addArrangedSubview(sortedByHighPriceBtn)
        sortingStackView.addArrangedSubview(sortedByLowPriceBtn)
        
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
        
        totalCountLabel.textColor = UIColor(red: 26/255, green: 190/255, blue: 88/255, alpha: 1)
        totalCountLabel.font = .boldSystemFont(ofSize: 14)
        sortingStackView.axis = .horizontal
        sortingStackView.spacing = 8
        sortingStackView.distribution = .fillProportionally
    }
    
    private func configureButtonActions() {
        let buttons = [sortedByAccuracyBtn, sortedByDateBtn, sortedByHighPriceBtn, sortedByLowPriceBtn]
        
        buttons.forEach {
            $0.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        }
    }
    
    @objc private func sortButtonClicked(_ sender: ShoppingSortButton) {
        let buttons = [sortedByAccuracyBtn, sortedByDateBtn, sortedByHighPriceBtn, sortedByLowPriceBtn]
        
        for btn in buttons {
            btn.isSelected = false
        }
        
        sender.isSelected = true
        
        let sortingType: String
        
        if sender == sortedByAccuracyBtn { sortingType = "sim" }
        else if sender == sortedByDateBtn { sortingType = "date" }
        else if sender == sortedByHighPriceBtn { sortingType = "dsc" }
        else { sortingType = "asc" }
        
        viewModel.input.sortButtonClicked.value = sortingType
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.output.shoppingList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let item = viewModel.output.shoppingList.value[indexPath.item]
        
        // html 태그 제거
        let reg = item.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        
        cell.productNameLabel.text = reg
        cell.mallNameLabel.text = item.mallName
        
        if let imgUrl = URL(string: item.image) {
            cell.productImageView.kf.setImage(with: imgUrl)
        }
        
        if let priceInInt = Int(item.lprice) {
            cell.productPriceLabel.text = "\(priceInInt.formatted())원"
        } else {
            cell.productPriceLabel.text = "\(item.lprice)원"
        }
        
        return cell
    }
}
