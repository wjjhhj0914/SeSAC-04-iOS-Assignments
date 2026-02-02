//
//  PhotoDetailViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/28/26.
//

import UIKit
import SnapKit
import Kingfisher

protocol PhotoDetailDelegate {
    func updateLikeStatus(id: String, isLiked: Bool)
}

class PhotoDetailViewController: BaseViewController {
    var delegate: PhotoDetailDelegate?
    var isLiked: Bool = false
    var initialState: Bool = false
    
    let likeButton = UIButton()
    
    var photoData: Photo?
    
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let mainImageView = UIImageView()
    
    let infoTitleLabel = UILabel()
    
    let sizeTitleLabel = UILabel()
    let viewsTitleLabel = UILabel()
    let downloadsTitleLabel = UILabel()
    
    let sizeValueLabel = UILabel()
    let viewsValueLabel = UILabel()
    let downloadsValueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialState = isLiked
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
    
    @objc func likeButtonClicked() {
        isLiked.toggle()
        updateLikeUI()
        
        print("좋아요 눌렀어요~ \(isLiked)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if initialState != isLiked {
            if photoData != nil {
                delegate?.updateLikeStatus(id: photoData!.id, isLiked: isLiked)
                print("성공")
            } else {
                print("실패")
            }
        } else {
            print("처음 상태와 동일!")
        }
    }
    
    func updateLikeUI() {
        let imageName = isLiked ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = isLiked ? .systemRed : .systemGray
    }
    
    override func configureHierarchy() {
        [nameLabel, dateLabel, mainImageView, infoTitleLabel,
         sizeTitleLabel, viewsTitleLabel, downloadsTitleLabel,
         sizeValueLabel, viewsValueLabel, downloadsValueLabel,
         likeButton].forEach { view.addSubview($0) }
    }
    
    override func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(1.2)
        }
        
        infoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(80)
        }
        
        // 크기 정보 섹션
        sizeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoTitleLabel.snp.top)
            make.leading.equalTo(infoTitleLabel.snp.trailing).offset(20)
        }
        sizeValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sizeTitleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        // 조회수 정보 섹션
        viewsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(sizeTitleLabel)
        }
        viewsValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(viewsTitleLabel)
            make.trailing.equalTo(sizeValueLabel)
        }
        
        // 다운로드 정보 섹션
        downloadsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(viewsTitleLabel.snp.bottom).offset(12)
            make.leading.equalTo(sizeTitleLabel)
        }
        downloadsValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(downloadsTitleLabel)
            make.trailing.equalTo(sizeValueLabel)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        setupLabel(label: nameLabel, fontSize: 14, weight: .regular)
        setupLabel(label: dateLabel, fontSize: 12)
        setupLabel(label: infoTitleLabel, fontSize: 20)
        
        [sizeTitleLabel, viewsTitleLabel, downloadsTitleLabel].forEach {
            setupLabel(label: $0, fontSize: 14)
        }
        [sizeValueLabel, viewsValueLabel, downloadsValueLabel].forEach {
            setupLabel(label: $0, fontSize: 14, weight: .regular)
        }
        
        infoTitleLabel.text = "정보"
        sizeTitleLabel.text = "크기"
        viewsTitleLabel.text = "조회수"
        downloadsTitleLabel.text = "다운로드"
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        
        updateLikeUI()
        
        if let data = photoData {
            nameLabel.text = data.user.name
            sizeValueLabel.text = "\(data.width) x \(data.height)"
            
            formatDate(dateString: data.created_at)
            
            if let url = URL(string: data.urls.full) {
                mainImageView.kf.setImage(with: url)
            }
            
            NetworkManager.shared.fetch(api: .statistics(id: data.id), type: PhotoStatistics.self) { stats in
                self.viewsValueLabel.text = stats.views.total.formatted()
                self.downloadsValueLabel.text = stats.downloads.total.formatted()
            } failureHandler: {
                print("통계 정보 가져오기 실패")
            }
        }
    }
    
    func formatDate(dateString: String) {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString) {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy년 M월 d일"
            let result = myFormatter.string(from: date)
            dateLabel.text = "\(result) 게시됨"
        }
    }

}
