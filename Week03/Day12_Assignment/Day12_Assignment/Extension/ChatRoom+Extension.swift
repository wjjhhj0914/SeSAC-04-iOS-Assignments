//
//  ChatRoom+Extension.swift
//  Day12_Assignment
//
//  Created by Hyojung Jang on 1/18/26.
//

import Foundation

extension ChatRoom {
    var otherUser: User? {
        // 친구 ID 찾기
        var friendId = 0
        
        for id in participantIds {
            if id != 0 {
                friendId = id
                break
            }
        }
        
        // 친구 정보 찾기
        for user in mockUsers {
            if user.userId == friendId {
                return user
            }
        }
        
        // 아무것도 없으면 nil 반환
        return nil
    }
}
