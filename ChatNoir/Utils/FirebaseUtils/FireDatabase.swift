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
    
//MARK: - Completion
    var postCompletion: (([Post]?, Error?) -> Void)? //pour pouvoir appeler cette completion dans une autre func
    
//MARK: - CollectionReferences
    
    let base = Firestore.firestore()
    
    var userCollection: CollectionReference {
        return base.collection("users")
    }
    var postsCollection: CollectionReference {
        return base.collection("posts")
    }
    
//MARK: - Query
    //requête de posts, trier(order) par date
    func postBaseQuery() -> Query {
        return postsCollection.order(by: KEY_DATE, descending: true)
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
    
    func addPost(_ data: [String: Any]) {
        postsCollection.document().setData(data)
    }
    
    func getPosts(_ category: PostCategory, _isFavorite: Bool, completion: (([Post]?, Error?) -> Void)?) {
        self.postCompletion = completion
        postBaseQuery().addSnapshotListener(handleListener(_:_:))
    }
    
    func handleListener(_ snapshot: QuerySnapshot?, _ error: Error?) {
        if error != nil {
            postCompletion?(nil, error)
        }
        if snapshot != nil {
            //on s'occupe de nos snaps pour les transformer en Post
            let documents = snapshot!.documents // ! à la place de ? car on a vérifier que != nil
            // on vient de récupérer un array de documents
            for document in documents {
                print(document.data())
            }
        }
    }
}
