//
//  PicsumViewController.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 1/20/26.
//

import UIKit

import SnapKit
import Alamofire
import Kingfisher

class PicsumViewController: UIViewController {
    
    let randomImageBtn = EntryButton(titleStr: "랜덤 이미지 불러오기")
    let renderImageView = PicsumImageView()
    let authorLabel = PicsumLabel(fontSize: 20)
    let screenResolutionLabel = PicsumLabel(fontSize: 14, textColour: .gray)
    
    @objc func randomImageBtnClicked() {
        callRequest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        randomImageBtn.addTarget(self, action: #selector(randomImageBtnClicked), for: .touchUpInside)
        
        callRequest()
    }
    
    func callRequest() {
        let url = "https://picsum.photos/id/\(Int.random(in: 0...100))/info"
        AF.request(url, method: .get)
            .responseDecodable(of: PicsumImage.self) { response in
                switch response.result {
                case .success(let value):
                    dump(value)
                    
                    self.authorLabel.text = value.author
                    self.screenResolutionLabel.text = "해상도: \(value.width) x \(value.height)"
                    DispatchQueue.main.async {
                        let kfUrl = URL(string: value.download_url)
                        self.renderImageView.kf.setImage(with: kfUrl)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension PicsumViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(randomImageBtn)
        view.addSubview(renderImageView)
        view.addSubview(authorLabel)
        view.addSubview(screenResolutionLabel)
    }
    
    func configureLayout() {
        randomImageBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(50)
        }
        
        renderImageView.snp.makeConstraints { make in
            make.top.equalTo(randomImageBtn.snp.bottom).offset(80)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(200)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(renderImageView.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.height.equalTo(28)
        }
        
        screenResolutionLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(2)
            make.centerX.equalTo(view)
            make.height.equalTo(28)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}
