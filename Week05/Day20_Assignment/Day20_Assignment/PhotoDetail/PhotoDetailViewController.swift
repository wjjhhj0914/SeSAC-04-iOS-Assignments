//
//  PhotoDetailViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/28/26.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoDetailViewController: BaseViewController {
    
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
        
    }
    
    override func configureHierarchy() {
        [nameLabel, dateLabel, mainImageView, infoTitleLabel,
         sizeTitleLabel, viewsTitleLabel, downloadsTitleLabel,
         sizeValueLabel, viewsValueLabel, downloadsValueLabel]
            .forEach { view.addSubview($0) }
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
    }
    
    override func configureView() {
        nameLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .boldSystemFont(ofSize: 12)
        infoTitleLabel.text = "정보"
        infoTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        [sizeTitleLabel, viewsTitleLabel, downloadsTitleLabel].forEach {
            $0.font = .boldSystemFont(ofSize: 14)
        }
        [sizeValueLabel, viewsValueLabel, downloadsValueLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
        }
        
        sizeTitleLabel.text = "크기"
        viewsTitleLabel.text = "조회수"
        downloadsTitleLabel.text = "다운로드"
        
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        
        if let data = photoData {
            nameLabel.text = data.user.name
            sizeValueLabel.text = "\(data.width) x \(data.height)"
            
            formatDate(dateString: data.created_at)
            
            if let url = URL(string: data.urls.full) {
                mainImageView.kf.setImage(with: url)
            }
            
            NetworkManager.shared.callRequestStatistics(id: data.id) { stats in
                self.viewsValueLabel.text = stats.views.total.formatted()
                self.downloadsValueLabel.text = stats.downloads.total.formatted()
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
