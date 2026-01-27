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
    }
    
    // 네트워크 통신
    func callRequest(query: String) {
        let url = "https://api.unsplash.com/search/photos"
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKey.UNSPLASH_ACCESS)"
        ]
        let parameters: Parameters = [
            "query": query,
            "page": 1,
            "per_page": 20
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: PhotoSearchResponse.self) { response in
                switch response.result {
                case .success(let value):
                    print(">>> 검색 결과 성공 >>>")
                    print("전체 사진 개수: \(value.total)")
                    self.photoList = value.results
                    self.mainView.collectionView.reloadData()
                
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
        callRequest(query: text)
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
        
        return cell
    }
    
    
}
