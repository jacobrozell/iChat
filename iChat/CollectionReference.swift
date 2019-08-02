//
//  CollectionReference.swift
//  iChat
//
//  Created by Jacob Rozell on 8/2/19.
//  Copyright © 2019 Jacob Rozell. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
