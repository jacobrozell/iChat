//
//  Recent.swift
//  iChat
//
//  Created by Jacob Rozell on 9/4/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import UIKit

func startPrivateChat(user1: FUser, user2: FUser) -> String {
    let userId1 = user1.objectId
    let userId2 = user2.objectId
    
    var chatRoomId = ""
    let value = userId1.compare(userId2).rawValue
    
    if value < 0 {
        chatRoomId = "\(userId1)\(userId2)"
    } else {
        chatRoomId = "\(userId2)\(userId1)"
    }
    
    let memebers: [String] = [userId1, userId2]
    
    // Create Recent Chats
    createRecentChat(members: memebers, chatRoomId: chatRoomId, withUserUserName: "", type: Constants.PRIVATE, users: [user1, user2], avatarOfGroup: nil)
    
    return chatRoomId
}

func createRecentChat(members: [String], chatRoomId: String, withUserUserName: String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    
    var tempMembers = members
    
    reference(.Recent).whereField(Constants.CHATROOMID, isEqualTo: chatRoomId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else { return }
        
        if snapshot.isEmpty {
            for recent in snapshot.documents {
                let currentRecent = recent.data() as NSDictionary
                if let currentUserId = currentRecent[Constants.USERID] {
                    if tempMembers.contains(currentUserId as! String) {
                        tempMembers.remove(at: tempMembers.firstIndex(of: currentUserId as! String)!)
                    }
                }
            }
        }
        
        for userID in tempMembers {
            //create recent items
            createRecentItem(userId: userID, chatRoomId: chatRoomId, members: members, withUserUserName: withUserUserName, type: type, users: users, avatarOfGroup: avatarOfGroup)
        }
    }
}

func createRecentItem(userId: String, chatRoomId: String, members: [String], withUserUserName: String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    let localReference = reference(.Recent).document()
    let recentId = localReference.documentID
    
    let date = dateFormatter().string(from: Date())
    
    var recent: [String: Any] = [:]
    
    if type == Constants.PRIVATE {
        var withUser: FUser?
        
        if users != nil && users!.count > 0 {
            if userId == FUser.currentId() {
                // creating an object for current user
                withUser = users!.last!
                
            } else {
                withUser = users!.first!
            }
        }
        
        recent = [
            Constants.RECENTID: recentId,
            Constants.USERID: userId,
            Constants.CHATROOMID: chatRoomId,
            Constants.MEMBERS: members,
            Constants.MEMBERSTOPUSH: members,
            Constants.WITHUSERFULLNAME: withUser!.fullname,
            Constants.WITHUSERUSERID: withUser!.objectId,
            Constants.LASTMESSAGE: "",
            Constants.COUNTER: 0,
            Constants.DATE: date,
            Constants.AVATAR: withUser!.avatar
            ]
        as [String: Any]
    }
    
    if type == Constants.GROUP {
        if avatarOfGroup != nil {
            recent = [
                Constants.RECENTID: recentId,
                Constants.USERID: userId,
                Constants.CHATROOMID: chatRoomId,
                Constants.MEMBERS: members,
                Constants.MEMBERSTOPUSH: members,
                Constants.WITHUSERUSERNAME: withUserUserName,
                Constants.LASTMESSAGE: "",
                Constants.COUNTER: 0,
                Constants.DATE: date,
                Constants.TYPE: type,
                Constants.AVATAR: avatarOfGroup!
            
                ]
            as [String: Any]
        }
    }
    
    // Save recent chat
    localReference.setData(recent)
}
