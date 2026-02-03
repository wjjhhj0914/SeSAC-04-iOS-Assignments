//
//  SearchPhotoViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/26/26.
//

import UIKit
import SnapKit
import Alamofire

enum SearchError: Error, LocalizedError {
    case isEmpty
    case tooShort
    
    var errorDescription: String? {
        switch self {
        case .isEmpty:
            return "검색어를 입력해 주세요"
        case .tooShort:
            return "두 글자 이상 입력해 주세요"
        }
    }
}

final class SearchPhotoViewController: BaseViewController {
    
    private let mainView = SearchPhotoView()
    private var photoList: [Photo] = []
    private var startPage = 1
    private var totalPage = 0
    private var colorChipsButtons: [UIButton] = []
    private var selectedColor: String? = nil // 현재 선택된 컬러 저장
    private var sortByLatest = false
    
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
        mainView.searchBar.enablesReturnKeyAutomatically = false
        mainView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        
        setupColorChips()
    }
    
    private func setupColorChips() {
        let colors = ["블랙", "화이트", "레드", "오렌지", "옐로우", "그린", "블루", "퍼플"]
        
        for color in colors {
            let button = ColorChipButton()
            button.configure(title: color)
            button.addTarget(self, action: #selector(colorChipsClicked), for: .touchUpInside)
            
            colorChipsButtons.append(button)
            mainView.stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func colorChipsClicked(_ sender: ColorChipButton) {
        for button in colorChipsButtons {
            button.configuration?.baseBackgroundColor = .systemGray6
            button.configuration?.baseForegroundColor = .black
        }
        
        sender.configuration?.baseBackgroundColor = .black
        sender.configuration?.baseForegroundColor = .white
        
        let colorDict = ["블랙": "black", "화이트": "white", "레드": "red", "오렌지": "orange", "옐로우": "yellow", "그린": "green", "블루": "blue", "퍼플": "purple"]
        
        if let koreanName = sender.configuration?.title {
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
    
    @objc private func sortButtonClicked() {
        sortByLatest.toggle()
        
        let title = sortByLatest ? "최신순" : "관련순"
        mainView.sortButton.setTitle(title, for: .normal)
        
        if let query = mainView.searchBar.text, !query.isEmpty {
            startPage = 1
            callRequest(query: query, color: selectedColor)
        }
    }
    
    private func callRequest(query: String, color: String? = nil) {
        let sort = sortByLatest ? "latest" : "relevant"
        
        NetworkManager.shared.fetch(api: .search(query: query, page: startPage, color: color, sort: sort), type: PhotoSearchResponse.self) { result in
            
            switch result {
            case .success(let value):
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
                } else {
                    // 결과가 하나도 없는 경우: "검색 결과가 없어요"로 레이블 텍스트 변경
                    self.mainView.collectionView.isHidden = true
                    self.mainView.noResultsLabel.isHidden = false
                    self.mainView.noResultsLabel.text = "검색 결과가 없어요."
                }
                self.mainView.collectionView.reloadData()
            case .failure(let error):
                self.showAlert(title: "알림", message: error.localizedDescription)
            }
        }
    }
}

    // 검색
    extension SearchPhotoViewController: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            do {
                let text = searchBar.text ?? ""
                if text.isEmpty {
                    throw SearchError.isEmpty
                }
                if text.count < 2 {
                    throw SearchError.tooShort
                }
                
                startPage = 1
                callRequest(query: text, color: selectedColor)
                view.endEditing(true)
            } catch {
                showAlert(title: "알림", message: error.localizedDescription)
            }
        }
    }
    
    // 좋아요
    extension SearchPhotoViewController: PhotoDetailDelegate {
        func updateLikeStatus(id: String, isLiked: Bool) {
            UserDefaults.standard.set(isLiked, forKey: id)
            mainView.collectionView.reloadData()
            print("좋아요 저장")
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
            
            cell.configure(data: data)
            
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
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = PhotoDetailViewController()
            let data = photoList[indexPath.item]
            
            vc.photoData = data
            vc.delegate = self
            vc.isLiked = UserDefaults.standard.bool(forKey: data.id)
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
