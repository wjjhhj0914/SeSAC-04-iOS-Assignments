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
        
        navigationItem.title = "TRAVEL TALK"

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
        
        cell.configure(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("클릭됐니?")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ChattingViewController") as! ChattingViewController
        
        let selectedChat = chatList[indexPath.item]
        vc.chatData = selectedChat
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
