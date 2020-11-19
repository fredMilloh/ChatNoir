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
//func pour ajouter un user (efface et met en place)
    func addUser(_ uid: String, data: [String: Any]) {
        userCollection.document(uid).setData(data)
    }
//func pour mettre à jour un user
    func updateUser(_ uid: String, data: [String: Any]) {
        userCollection.document(uid).updateData(data)
    }
    
//func pour recupérer les data du user, besoin d'une complétion, pour afficher résultats une fois récupérer
    //ici complétion en typealias UserCompletion dans les constantes
    func getMe(completion: UserCompletion?) {
        if let uid = FireAuth().myId() {
           //ici pour récupérer les data on peut utiliser get, ou snapshotListener, qui écoute les éventuelles Maj du User
            userCollection.document(uid).addSnapshotListener { (doc, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    completion?(nil)
                }
                if doc != nil {
                    print(doc!.data() as Any)
                    let newUser = User(doc!)
                    completion?(newUser)
                }
            }
        } else {
            completion?(nil)
        }
    }
}
