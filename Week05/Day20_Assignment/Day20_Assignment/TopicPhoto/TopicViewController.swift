//
//  TopicViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/27/26.
//

import UIKit
import SnapKit
import Kingfisher

class TopicViewController: BaseViewController {
    
    var goldenHourList: [Photo] = []
    var businessList: [Photo] = []
    var architectureList: [Photo] = []
    
    let topics = ["golden-hour", "business-work", "architecture-interior"]

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let mainTitleLabel = UILabel()
    
    let goldenTitleLabel = UILabel()
    let businessTitleLabel = UILabel()
    let architectureTitleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        NetworkManager.shared.callRequestTopic(topicName: topics[0]) { photos in
            self.goldenHourList = photos
            self.goldenCollectionView.reloadData()
        }
        
        NetworkManager.shared.callRequestTopic(topicName: topics[1]) { photos in
            self.businessList = photos
            self.businessCollectionView.reloadData()
        }
        
        NetworkManager.shared.callRequestTopic(topicName: topics[2]) { photos in
            self.architectureList = photos
            self.architectureCollectionView.reloadData()
        }
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return layout
    }
    
    lazy var goldenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var businessCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var architectureCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    

    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            mainTitleLabel,
            goldenTitleLabel, businessTitleLabel, architectureTitleLabel,
            goldenCollectionView, businessCollectionView, architectureCollectionView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView) // 세로 스크롤을 위한 너비 고정
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        // golden hour section
        goldenTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(30)
            make.leading.equalTo(mainTitleLabel)
        }
        goldenCollectionView.snp.makeConstraints { make in
            make.top.equalTo(goldenTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
        }
        
        // business section
        businessTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(goldenCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(mainTitleLabel)
        }
        businessCollectionView.snp.makeConstraints { make in
            make.top.equalTo(businessTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
        }
        
        // architecture section
        architectureTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(businessCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(mainTitleLabel)
        }
        architectureCollectionView.snp.makeConstraints { make in
            make.top.equalTo(architectureTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        mainTitleLabel.text = "OUR TOPIC"
        mainTitleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        goldenTitleLabel.text = "골든 아워"
        businessTitleLabel.text = "비즈니스 및 업무"
        architectureTitleLabel.text = "건축 및 인테리어"
        
        goldenTitleLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        businessTitleLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        architectureTitleLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        
        [goldenCollectionView, businessCollectionView, architectureCollectionView].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        }
    }
}

extension TopicViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == goldenCollectionView { return goldenHourList.count }
        if collectionView == businessCollectionView { return businessList.count }
        return architectureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        let data: Photo
        
        if collectionView == goldenCollectionView {
            data = goldenHourList[indexPath.item]
        } else if collectionView == businessCollectionView {
            data = businessList[indexPath.item]
        } else {
            data = architectureList[indexPath.item]
        }
        
        if let url = URL(string: data.urls.thumb) {
            cell.photoImageView.kf.setImage(with: url)
        }
        cell.likesLabel.text = data.likes.formatted()
        
        return cell
    }
    
    
}
