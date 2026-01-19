//
//  FriendProfileViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/19/26.
//

import UIKit

import SnapKit
import Kingfisher

class FriendProfileViewController: UIViewController {
    
    var nickname: String = "알 수 없음"
    var profileImageUrl: String?
    
    private let profileImageView = UIImageView()
    private let nicknameDescriptionLabel = UILabel()
    private let usernameLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierachy()
        setupConstraints()
        configureView()
    }
    
    private func setupHierachy() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameDescriptionLabel)
        view.addSubview(usernameLabel)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        nicknameDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView).offset(115)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView).offset(140)
        }
    }
    
    private func configureView() {
        navigationItem.title = "Travel Friends"
        
        nicknameDescriptionLabel.text = "닉네임"
        nicknameDescriptionLabel.textColor = .gray
        nicknameDescriptionLabel.font = .systemFont(ofSize: 14)
        
        usernameLabel.text = nickname
        usernameLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
        
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.clipsToBounds = true
        
        let url = URL(string: profileImageUrl ?? "")
        profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle.fill"))
    }

}
