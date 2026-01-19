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
        
        mainSearchBar.delegate = self
        
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

extension TalkViewController: UISearchBarDelegate {
    // 키보드의 검색 버튼을 눌렀을 때 실행되는 함수
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty {
            // 검색어가 있는 경우
            // 1단계: 검색된 결과물 담을 빈 바구니 생성
            var filteredResult: [ChatRoom] = []
            
            // 2단계: 전체 데이터를 하나씩 꺼내서 확인
            for chatRoom in mockChatRooms {
                var isNameMatched = false
                
                // 3단계: id를 꺼내서 비교
                for participantId in chatRoom.participantIds {
                    // 4단계: 전체 유저 목록에서 해당 id를 가진 유저를 찾는다
                    for user in mockUsers {
                        if user.userId == participantId {
                            // 5단계: 그 id를 가진 유저가 검색어에 포함되어 있는지 확인
                            if user.userName.contains(text.lowercased()) {
                                isNameMatched = true
                            }
                        }
                    }
                }
                
                // 6단계: 있으면 바구니에 담음
                if isNameMatched {
                    filteredResult.append(chatRoom)
                }
            }
            // 7단계: 바구니 교체
            chatList = filteredResult
        } else {
            // 공란일 경우 전체 친구 목록 보여주기
            chatList = mockChatRooms
        }
        
        chatListCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}
