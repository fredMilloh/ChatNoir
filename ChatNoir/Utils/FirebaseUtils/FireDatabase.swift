//
//  FireDatabase.swift
//  ChatNoir
//
//  Created by fred on 12/11/2020.
//

import Foundation
import UIKit
import Firebase

class FireDatabase {
    
    let base = Firestore.firestore()
    
    var userCollection: CollectionReference {
        return base.collection("users")
    }
    var postsCollection: CollectionReference {
        return base.collection("posts")
    }
    
    func addUser(_ uid: String, data: [String: Any]) {
        userCollection.document(uid).setData(data)
    }
}
