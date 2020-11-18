//
//  User.swift
//  ChatNoir
//
//  Created by fred on 18/11/2020.
//

import Foundation
import FirebaseFirestore

class User {
    
    var ref: DocumentReference
    var uid: String
    var surname: String
    var name: String
    var imageUrl: String?
    var coverUrl: String?
    
    init(_ document: DocumentSnapshot) {
        ref = document.reference
        uid = document.documentID
        let data = document.data() ?? [:]
        name = data[KEY_NAME] as? String ?? ""
        surname = data[KEY_SURNAME] as? String ?? ""
        imageUrl = data[KEY_IMAGEURL] as? String
        coverUrl = data[KEY_COVERURL] as? String
    }
}
