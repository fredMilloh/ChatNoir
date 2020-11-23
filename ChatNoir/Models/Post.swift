//
//  Post.swift
//  ChatNoir
//
//  Created by fred on 23/11/2020.
//

import Foundation
import Firebase

class Post {
    var ref: DocumentReference
    var uid: String
    var text: String
    var category: String
    var userID: String
    var date: Double
    var imageUrl: String?
    var cat: [String] //String = userID de ceux qui votent
    var fox: [String]
    
    init(_ document: DocumentSnapshot) {
        ref = document.reference
        uid = document.documentID
        let data = document.data() ?? [:]
        text = data[KEY_TEXT] as? String ?? ""
        category = data[KEY_CATEGORY] as? String ?? ""
        userID = data[KEY_UID] as? String ?? ""
        date = data[KEY_DATE] as? Double ?? 0.0
        imageUrl = data[KEY_IMAGEURL] as? String
        cat = data[KEY_CAT] as? [String] ?? []
        fox = data[KEY_FOX] as? [String] ?? []
    }
}
