//
//  TalkViewController.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import UIKit

import Kingfisher

class TalkViewController: UIViewController {
    
    @IBOutlet var mainSearchBar: UISearchBar!
    @IBOutlet var chatListCollectionView: UICollectionView!
    
    private var chatList: [ChatRoom] = mockChatRooms
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatListCollectionView.delegate = self
        chatListCollectionView.dataSource = self
        
        let xib = UINib(nibName: TalkCollectionViewCell.identifier, bundle: nil)
        chatListCollectionView.register(xib, forCellWithReuseIdentifier: TalkCollectionViewCell.identifier)
        
        configureLayout()
        
        navigationItem.title = "채팅 화면"

        mainSearchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    private func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 80)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        chatListCollectionView.collectionViewLayout = layout
    }

}

extension TalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TalkCollectionViewCell.identifier, for: indexPath) as! TalkCollectionViewCell
        
        let data = chatList[indexPath.item]
        
        var friendId = 0
        // 0이 아닌 번호를 찾을 때까지 for문 돌리기
        for id in data.participantIds {
            if id != 0 {
                friendId = id
                break
            }
        }

        for user in mockUsers {
            if user.userId == friendId {
                cell.nameLabel.text = user.userName
                let url = URL(string: user.profileImage)
                cell.profileImageView.kf.setImage(with: url)
                break
            }
        }
        
        if data.messages.count > 0 {
            let lastChat = data.messages[data.messages.count - 1]
            cell.messageLabel.text = lastChat.content
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yy.MM.dd"
            
            cell.dateLabel.text = formatter.string(from: lastChat.timestamp)
        }
        
        return cell
    }
}
