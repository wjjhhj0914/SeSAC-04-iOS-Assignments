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
    var shoppingList: [ShoppingItems] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        navigationItem.title = searchKeyword
        
        callRequest(query: searchKeyword ?? "", sort: "sim")
        
        configureButtonActions()
        
        sortedByAccuracyBtn.isSelected = true
        sortedByAccuracyBtn.changeBtnDesign(isSelected: true)
    }
    
    func configureButtonActions() {
        let buttons = [sortedByAccuracyBtn, sortedByDateBtn, sortedByHighPriceBtn, sortedByLowPriceBtn]
        
        buttons.forEach {
            $0.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        }
    }
    
    @objc func sortButtonClicked(_ sender: ShoppingSortButton) {
        let buttons = [sortedByAccuracyBtn, sortedByDateBtn, sortedByHighPriceBtn, sortedByLowPriceBtn]
        
        for btn in buttons {
            btn.changeBtnDesign(isSelected: false)
        }
        
        sender.changeBtnDesign(isSelected: true)
        
        var sortingType = ""
        
        if sender == sortedByAccuracyBtn {
            sortingType = "sim"
        } else if sender == sortedByDateBtn {
            sortingType = "date"
        } else if sender == sortedByHighPriceBtn {
            sortingType = "dsc"
        } else if sender == sortedByLowPriceBtn {
            sortingType = "asc"
        }
        
        callRequest(query: searchKeyword ?? "", sort: sortingType)
    }
    
    func callRequest(query: String, sort: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_CLIENT_ID, "X-Naver-Client-Secret": APIKey.NAVER_CLIENT_SECRET]
        let parameters: Parameters = ["query": query, "display": 100, "sort": sort]
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: ShoppingData.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    self.totalCountLabel.text = "\(value.total.formatted())개의 검색 결과"
                    self.shoppingList = value.items
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
    static func layout() -> UICollectionViewFlowLayout {
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
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let item = shoppingList[indexPath.item]
        
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
    
        totalCountLabel.textColor = UIColor(red: 26/255, green: 190/255, blue: 88/255, alpha: 1)
        totalCountLabel.font = .boldSystemFont(ofSize: 14)
        
        sortingStackView.axis = .horizontal
        sortingStackView.spacing = 8
        sortingStackView.distribution = .fillProportionally
    }
}
