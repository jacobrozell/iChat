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
    public static let kFILEREFERENCE = ""
    public static let kONESIGNALAPPID = ""
    public static let kSINCHKEY = ""
    public static let kSINCHSECRET = ""
    public static let kAPPURL = ""


    //Firebase Headers
    public static let kUSER_PATH = "User"
    public static let kTYPINGPATH_PATH = "Typing"
    public static let kRECENT_PATH = "Recent"
    public static let kMESSAGE_PATH = "Message"
    public static let kGROUP_PATH = "Group"
    public static let kCALL_PATH = "Call"

    //FUser
    public static let kOBJECTID = "objectId"
    public static let kCREATEDAT = "createdAt"
    public static let kUPDATEDAT = "updatedAt"
    public static let kEMAIL = "email"
    public static let kPHONE = "phone"
    public static let kCOUNTRYCODE = "countryCode"
    public static let kFACEBOOK = "facebook"
    public static let kLOGINMETHOD = "loginMethod"
    public static let kPUSHID = "pushId"
    public static let kFIRSTNAME = "firstname"
    public static let kLASTNAME = "lastname"
    public static let kFULLNAME = "fullname"
    public static let kAVATAR = "avatar"
    public static let kCURRENTUSER = "currentUser"
    public static let kISONLINE = "isOnline"
    public static let kVERIFICATIONCODE = "firebase_verification"
    public static let kCITY = "city"
    public static let kCOUNTRY = "country"
    public static let kBLOCKEDUSERID = "blockedUserId"


    //
    public static let kBACKGROUBNDIMAGE = "backgroundImage"
    public static let kSHOWAVATAR = "showAvatar"
    public static let kPASSWORDPROTECT = "passwordProtect"
    public static let kFIRSTRUN = "firstRun"
    public static let kNUMBEROFMESSAGES = 10
    public static let kMAXDURATION = 120.0
    public static let kAUDIOMAXDURATION = 120.0
    public static let kSUCCESS = 2

    //recent
    public static let kCHATROOMID = "chatRoomID"
    public static let kUSERID = "userId"
    public static let kDATE = "date"
    public static let kPRIVATE = "private"
    public static let kGROUP = "group"
    public static let kGROUPID = "groupId"
    public static let kRECENTID = "recentId"
    public static let kMEMBERS = "members"
    public static let kMESSAGE = "message"
    public static let kMEMBERSTOPUSH = "membersToPush"
    public static let kDISCRIPTION = "discription"
    public static let kLASTMESSAGE = "lastMessage"
    public static let kCOUNTER = "counter"
    public static let kTYPE = "type"
    public static let kWITHUSERUSERNAME = "withUserUserName"
    public static let kWITHUSERUSERID = "withUserUserID"
    public static let kOWNERID = "ownerID"
    public static let kSTATUS = "status"
    public static let kMESSAGEID = "messageId"
    public static let kNAME = "name"
    public static let kSENDERID = "senderId"
    public static let kSENDERNAME = "senderName"
    public static let kTHUMBNAIL = "thumbnail"
    public static let kISDELETED = "isDeleted"

    //Contacts
    public static let kCONTACT = "contact"
    public static let kCONTACTID = "contactId"

    //message types
    public static let kPICTURE = "picture"
    public static let kTEXT = "text"
    public static let kVIDEO = "video"
    public static let kAUDIO = "audio"
    public static let kLOCATION = "location"

    //coordinates
    public static let kLATITUDE = "latitude"
    public static let kLONGITUDE = "longitude"


    //message status
    public static let kDELIVERED = "delivered"
    public static let kREAD = "read"
    public static let kREADDATE = "readDate"
    public static let kDELETED = "deleted"


    //push
    public static let kDEVICEID = "deviceId"


    //Call
    public static let kISINCOMING = "isIncoming"
    public static let kCALLERID = "callerId"
    public static let kCALLERFULLNAME = "callerFullName"
    public static let kCALLSTATUS = "callStatus"
    public static let kWITHUSERFULLNAME = "withUserFullName"
    public static let kCALLERAVATAR = "callerAvatar"
    public static let kWITHUSERAVATAR = "withUserAvatar"
}

