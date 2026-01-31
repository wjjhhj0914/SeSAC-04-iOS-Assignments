//
//  TopicView.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/31/26.
//

import UIKit
import SnapKit

class TopicView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let mainTitleLabel = UILabel()
    let goldenTitleLabel = UILabel()
    let businessTitleLabel = UILabel()
    let architectureTitleLabel = UILabel()
    
    private func createLayout() -> UICollectionViewFlowLayout {
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [mainTitleLabel,
         goldenTitleLabel, businessTitleLabel, architectureTitleLabel,
         goldenCollectionView, businessCollectionView, architectureCollectionView,
        ].forEach { contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        goldenTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(30)
            make.leading.equalTo(mainTitleLabel)
        }
        goldenCollectionView.snp.makeConstraints { make in
            make.top.equalTo(goldenTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
        }
        
        businessTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(goldenCollectionView.snp.bottom).offset(30)
            make.leading.equalTo(mainTitleLabel)
        }
        businessCollectionView.snp.makeConstraints { make in
            make.top.equalTo(businessTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(220)
        }
        
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
        mainTitleLabel.text = "OUR TOPIC"
        mainTitleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        goldenTitleLabel.text = "골든 아워"
        businessTitleLabel.text = "비즈니스 및 업무"
        architectureTitleLabel.text = "건축 및 인테리어"
        
        [goldenTitleLabel, businessTitleLabel, architectureTitleLabel].forEach {
            $0.font = .systemFont(ofSize: 18, weight: .heavy)
        }
    }
}
