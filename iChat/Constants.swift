//
//  Constants.swift
//  iChat
//
//  Created by Jacob Rozell on 8/2/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public var recentBadgeHandler: ListenerRegistration?
let userDefaults = UserDefaults.standard

enum Constants {
    //NOTIFICATIONS
    public static let USER_DID_LOGIN_NOTIFICATION = "UserDidLoginNotification"
    public static let APP_STARTED_NOTIFICATION = "AppStartedNotification"


    //IDS and Keys
    public static let FILEREFERENCE = ""
    public static let ONESIGNALAPPID = ""
    public static let SINCHKEY = ""
    public static let SINCHSECRET = ""
    public static let APPURL = ""


    //Firebase Headers
    public static let USER_PATH = "User"
    public static let TYPINGPATH_PATH = "Typing"
    public static let RECENT_PATH = "Recent"
    public static let MESSAGE_PATH = "Message"
    public static let GROUP_PATH = "Group"
    public static let CALL_PATH = "Call"

    //FUser
    public static let OBJECTID = "objectId"
    public static let CREATEDAT = "createdAt"
    public static let UPDATEDAT = "updatedAt"
    public static let EMAIL = "email"
    public static let PHONE = "phone"
    public static let COUNTRYCODE = "countryCode"
    public static let FACEBOOK = "facebook"
    public static let LOGINMETHOD = "loginMethod"
    public static let PUSHID = "pushId"
    public static let FIRSTNAME = "firstname"
    public static let LASTNAME = "lastname"
    public static let FULLNAME = "fullname"
    public static let AVATAR = "avatar"
    public static let CURRENTUSER = "currentUser"
    public static let ISONLINE = "isOnline"
    public static let VERIFICATIONCODE = "firebase_verification"
    public static let CITY = "city"
    public static let COUNTRY = "country"
    public static let BLOCKEDUSERID = "blockedUserId"


    public static let BACKGROUBNDIMAGE = "backgroundImage"
    public static let SHOWAVATAR = "showAvatar"
    public static let PASSWORDPROTECT = "passwordProtect"
    public static let FIRSTRUN = "firstRun"
    public static let NUMBEROFMESSAGES = 10
    public static let MAXDURATION = 120.0
    public static let AUDIOMAXDURATION = 120.0
    public static let SUCCESS = 2

    //recent
    public static let CHATROOMID = "chatRoomID"
    public static let USERID = "userId"
    public static let DATE = "date"
    public static let PRIVATE = "private"
    public static let GROUP = "group"
    public static let GROUPID = "groupId"
    public static let RECENTID = "recentId"
    public static let MEMBERS = "members"
    public static let MESSAGE = "message"
    public static let MEMBERSTOPUSH = "membersToPush"
    public static let DISCRIPTION = "discription"
    public static let LASTMESSAGE = "lastMessage"
    public static let COUNTER = "counter"
    public static let TYPE = "type"
    public static let WITHUSERUSERNAME = "withUserUserName"
    public static let WITHUSERUSERID = "withUserUserID"
    public static let OWNERID = "ownerID"
    public static let STATUS = "status"
    public static let MESSAGEID = "messageId"
    public static let NAME = "name"
    public static let SENDERID = "senderId"
    public static let SENDERNAME = "senderName"
    public static let THUMBNAIL = "thumbnail"
    public static let ISDELETED = "isDeleted"

    //Contacts
    public static let CONTACT = "contact"
    public static let CONTACTID = "contactId"

    //message types
    public static let PICTURE = "picture"
    public static let TEXT = "text"
    public static let VIDEO = "video"
    public static let AUDIO = "audio"
    public static let LOCATION = "location"

    //coordinates
    public static let LATITUDE = "latitude"
    public static let LONGITUDE = "longitude"


    //message status
    public static let DELIVERED = "delivered"
    public static let READ = "read"
    public static let READDATE = "readDate"
    public static let DELETED = "deleted"


    //push
    public static let DEVICEID = "deviceId"


    //Call
    public static let ISINCOMING = "isIncoming"
    public static let CALLERID = "callerId"
    public static let CALLERFULLNAME = "callerFullName"
    public static let CALLSTATUS = "callStatus"
    public static let WITHUSERFULLNAME = "withUserFullName"
    public static let CALLERAVATAR = "callerAvatar"
    public static let WITHUSERAVATAR = "withUserAvatar"
}
