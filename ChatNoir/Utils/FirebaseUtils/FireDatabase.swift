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
    
    func getUser(_ uid: String, completion: UserCompletion?) {
        userCollection.document(uid).addSnapshotListener { (doc, error) in
            if error != nil {
                completion?(nil)
            }
            if doc != nil {
                completion?(User(doc!))
            }
        }
    }
    
    func addPost(_ data: [String: Any]) {
        postsCollection.document().setData(data)
    }
    
    func getPosts(_ category: PostCategory, _ isFavorite: Bool, completion: (([Post]?, Error?) -> Void)?) -> ListenerRegistration {
        self.postCompletion = completion
        if isFavorite { //on return les posts où on(=user connecté) aura mis chat
            if let uid = FireAuth().myId() {
                if category == .none {
                    //attention nouveau whereField donc nouvel index dans Firebase
                    return postBaseQuery().whereField(KEY_CAT, arrayContains: uid).addSnapshotListener(handleListener(_:_:))
                } else {
                    return postBaseQuery().whereField(KEY_CAT, arrayContains: uid).whereField(KEY_CATEGORY, isEqualTo: category.rawValue).addSnapshotListener(handleListener(_:_:))
                }
            } else {
                return postBaseQuery().addSnapshotListener(handleListener(_:_:))
            }
        } else {
            if category == .none {
                return postBaseQuery().addSnapshotListener(handleListener(_:_:))
            } else {
                return postBaseQuery().whereField(KEY_CATEGORY, isEqualTo: category.rawValue).addSnapshotListener(handleListener(_:_:))
            }
        }
    }
    
    //pour récupérer les posts uniques d'un user
    func getPostsFrom(_ userId: String, completion: (([Post]?, Error?) -> Void)?) {
        self.postCompletion = completion
        //attention avec whereField -> listen failed dans la console -> créer index dans firebase
        postBaseQuery().whereField(KEY_UID, isEqualTo: userId).addSnapshotListener(handleListener(_:_:))
        
    }
    
    func handleListener(_ snapshot: QuerySnapshot?, _ error: Error?) {
        if error != nil {
            postCompletion?(nil, error)
        }
        if snapshot != nil {
            var posts: [Post] = []
            let documents = snapshot!.documents // ! à la place de ? car on a vérifier que != nil
            // on vient de récupérer un array de documents
            for document in documents {
                posts.append(Post(document))
            }
            postCompletion?(posts, nil)
        }
    }
    
    func addOrRemoveLike(_ cat: Bool, _ post: Post) {
        guard let uid = FireAuth().myId() else { return }
        let valueOne = cat ? KEY_CAT : KEY_FOX
        let valueTwo = cat ? KEY_FOX : KEY_CAT
        //si l'user: clique sur cat, et qu'il a déjà cliquer dessus, OU sur pas cat (donc fox) et qu'il a déjà cliquer fox
        if (cat && post.cat.contains(uid)) || (!cat && post.fox.contains(uid)) {
            //on retire son vote (uid) du post
            post.ref.updateData([valueOne: FieldValue.arrayRemove([uid])])
        } else { //si cat est déjà cliqué et que l'user clique sur fox, on change le vote
            post.ref.updateData([valueOne: FieldValue.arrayUnion([uid]), valueTwo: FieldValue.arrayRemove([uid])])
        }
    }
}
