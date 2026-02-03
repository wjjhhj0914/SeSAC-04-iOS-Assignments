//
//  TopicViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit
import SnapKit

final class TopicViewController: BaseViewController {
    private let mainView = TopicView()
    private let profileButton = UIButton()
    
    private var goldenHourList: [Photo] = []
    private var businessList: [Photo] = []
    private var architectureList: [Photo] = []
    private let topics = ["golden-hour", "business-work", "architecture-interior"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    override func configureHierarchy() {
        view.addSubview(mainView)
    }
    
    override func configureLayout() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
    
    override func configureView() {
        super.configureView()

        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileButton.tintColor = .systemGray
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        [mainView.goldenCollectionView, mainView.businessCollectionView, mainView.architectureCollectionView].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.register(TopicCollectionViewCell.self,
                        forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)
        }
    }
    
    @objc private func profileButtonTapped() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        var hasErrorOccured = false
        
        for (index, topicName) in topics.enumerated() {
            group.enter()
            
            NetworkManager.shared.fetch(api: .topics(topicName: topicName), type: [Photo].self) { result in
                
                switch result {
                case .success(let photos):
                    if index == 0 { self.goldenHourList = photos }
                    else if index == 1 { self.businessList = photos }
                    else { self.architectureList = photos }
                case .failure(let error):
                    hasErrorOccured = true
                    print(error.localizedDescription)
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if hasErrorOccured {
                self.showAlert(title: "알림", message: "데이터를 불러오는 데 실패했습니다.")
            }
            self.mainView.goldenCollectionView.reloadData()
            self.mainView.businessCollectionView.reloadData()
            self.mainView.architectureCollectionView.reloadData()
        }
    }
    
    private func getPhoto(collectionView: UICollectionView, index: Int) -> Photo {
        if collectionView == mainView.goldenCollectionView {
            return goldenHourList[index]
        } else if collectionView == mainView.businessCollectionView {
            return businessList[index]
        } else {
            return architectureList[index]
        }
    }
}

extension TopicViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.goldenCollectionView { return goldenHourList.count }
        if collectionView == mainView.businessCollectionView { return businessList.count }
        return architectureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as! TopicCollectionViewCell
        
        let data = getPhoto(collectionView: collectionView, index: indexPath.item)
        
        cell.configure(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = getPhoto(collectionView: collectionView, index: indexPath.item)
        
        vc.photoData = data
        vc.delegate = self
        vc.isLiked = UserDefaults.standard.bool(forKey: data.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopicViewController: PhotoDetailDelegate {
    func updateLikeStatus(id: String, isLiked: Bool) {
        UserDefaults.standard.set(isLiked, forKey: id)
        mainView.goldenCollectionView.reloadData()
        mainView.businessCollectionView.reloadData()
        mainView.architectureCollectionView.reloadData()
    }
}
