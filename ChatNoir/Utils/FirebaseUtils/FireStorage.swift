//
//  FireStorage.swift
//  ChatNoir
//
//  Created by fred on 19/11/2020.
//

import Foundation
import Firebase

class FireStorage {
    
    let base = Storage.storage().reference()
    
    func userProfile(_ uid: String) -> StorageReference {
        return base.child(uid).child(KEY_IMAGEURL)
    }
    
    func userCover(_ uid: String) -> StorageReference {
        return base.child(uid).child(KEY_COVERURL)
    }
    
    func post(_ uid: String, timeStamp: Double) -> StorageReference {
        return base.child(uid).child("posts").child("\(timeStamp)")
    }
    
    func sendImageToFirebase(_ ref: StorageReference, _ image: UIImage, completion: ImageUploadCompletion?) {
        //on compresse l'image en jpeg, qualité petite car image petite sur appli
        guard let data = image.jpegData(compressionQuality: 0.3) else { return }
        ref.putData(data, metadata: nil) { (meta, error) in
            if error != nil {
                print(error!.localizedDescription)
                completion?(nil, error)
            }
            if meta != nil {
                ref.downloadURL { (url, error) in
                    if error != nil {
                        completion?(nil, error)
                    }
                    if url != nil {
                        completion?(url!.absoluteString, nil) //pour transformer l'url en String
                    }
                }
            }
        }
    }
}
