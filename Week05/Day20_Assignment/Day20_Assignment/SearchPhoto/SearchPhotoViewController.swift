//
//  SearchPhotoViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/26/26.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class SearchPhotoViewController: BaseViewController {
    let mainView = SearchPhotoView()
    
    var photoList: [Photo] = []
    var startPage = 1
    var totalPage = 0
    
    var colorChipsButtons: [UIButton] = []
    var selectedColor: String? = nil // 현재 선택된 컬러 저장
    
    var sortByLatest = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SEARCH PHOTO"
    }
    
    override func configureHierarchy() {
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        mainView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        
        setupColorChips()
    }
    
    func setupColorChips() {
        let colors = ["블랙", "화이트", "레드", "오렌지", "옐로우", "그린", "블루", "퍼플"]
        
        for color in colors {
            let button = UIButton()
            
            button.setTitle(color, for: .normal)
            button.backgroundColor = .systemGray6
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 20
            button.titleLabel?.font = .boldSystemFont(ofSize: 14)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            button.addTarget(self, action: #selector(colorChipsClicked), for: .touchUpInside)
            
            colorChipsButtons.append(button)
            
            mainView.stackView.addArrangedSubview(button)
        }
    }
    
    @objc func colorChipsClicked(_ sender: UIButton) {
        for button in colorChipsButtons {
            button.backgroundColor = .systemGray6
            button.setTitleColor(.black, for: .normal)
        }
        
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        
        let colorDict = ["블랙": "black", "화이트": "white", "레드": "red", "오렌지": "orange", "옐로우": "yellow", "그린": "green", "블루": "blue", "퍼플": "purple"]
        
        if let koreanName = sender.currentTitle {
            if let englishName = colorDict[koreanName] {
                self.selectedColor = englishName
                if let query = mainView.searchBar.text, !query.isEmpty {
                    startPage = 1
                    callRequest(query: query, color: englishName)
                } else {
                    print("검색어 비었음")
                }
            } else {
                print("없는 색상")
            }
        } else {
            print("없음!")
        }
    }
    
    @objc func sortButtonClicked() {
        sortByLatest.toggle()
        
        let title = sortByLatest ? "최신순" : "관련순"
        mainView.sortButton.setTitle(title, for: .normal)
        
        if let query = mainView.searchBar.text, !query.isEmpty {
            startPage = 1
            callRequest(query: query, color: selectedColor)
        }
    }
    
    // 네트워크 통신
    // color는 선택사항이므로 옵셔널
    func callRequest(query: String, color: String? = nil) {
        let url = "https://api.unsplash.com/search/photos"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(APIKey.UNSPLASH_ACCESS)"]
        let sort = sortByLatest ? "latest" : "relevant"
        var parameters: Parameters = [
            "query": query,
            "page": startPage,
            "per_page": 20,
            "order_by": sort
        ]
        
        if let color = color {
            parameters["color"] = color
        }
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: PhotoSearchResponse.self) { response in
                switch response.result {
                case .success(let value):
                    
                    // 검색어에 해당하는 사진의 페이지는 몇 개의 페이지가 있는지
                    self.totalPage = value.total_pages
                    let hasResults = value.total > 0
                    
                    if hasResults {
                        // 결과가 있는 경우: "사진을 검색해 보세요" 레이블 숨기고 CV 표시
                        self.mainView.collectionView.isHidden = false
                        self.mainView.noResultsLabel.isHidden = true
                        
                        if self.startPage == 1 {
                            self.photoList = value.results
                            print("20개 먼저 보여줄게")
                        } else {
                            self.photoList.append(contentsOf: value.results)
                            print("추가추가")
                        }
                        self.mainView.collectionView.reloadData()
                    } else {
                        // 결과가 하나도 없는 경우: "검색 결과가 없어요"로 레이블 텍스트 변경
                        self.mainView.collectionView.isHidden = true
                        self.mainView.noResultsLabel.isHidden = false
                        self.mainView.noResultsLabel.text = "검색 결과가 없어요."
                    }
                    
                case .failure(let error):
                    print(">>> 에러 발생 >>> 에러: \(error)")
                }
            }
    }
}

// 검색
extension SearchPhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            showAlert(title: "알림", message: "검색어를 입력해 주세요!")
            return
        }
        // 검색 시 페이지 1로 다시 초기화 및 네트워크 통신
        startPage = 1
        callRequest(query: text, color: selectedColor)
        view.endEditing(true)
    }
}

// CollectionView
extension SearchPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let data = photoList[indexPath.row]
        if let url = URL(string: data.urls.thumb) {
            cell.photoImageView.kf.setImage(with: url)
        }
        
        cell.likesLabel.text = data.likes.formatted()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 마지막에서 두 번째 셀이 보일 때 다음 페이지 불러오기
        // 그리고 현재 페이지가 전체 페이지보다 작을 때만 (<= 더 줄 사진이 없는데 네트워크 요청할 때를 방지하기 위함)
        if photoList.count - 2 == indexPath.item && startPage < totalPage {
            startPage += 1
            callRequest(query: mainView.searchBar.text!, color: selectedColor)
        }
    }
}
