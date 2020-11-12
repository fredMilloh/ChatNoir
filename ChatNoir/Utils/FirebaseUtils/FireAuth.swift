//
//  FireAuth.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import Foundation
import Firebase

class FireAuth {
    
    let auth = Auth.auth()
    var completion: ((_ uid: String?, _ error: String?) -> Void)?
    
    
    // pour vérifier si on est authentifier
    func isAuth() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
    
    func signIn(_ mail: String, _ pwd: String, completion: ((_ uid: String?, _ error: String?) -> Void)?) {
        self.completion = completion
        auth.signIn(withEmail: mail, password: pwd, completion: handleResult(_:_:))
        
    }
    
    func createUser(_ mail: String, _ pwd: String, completion: ((_ uid: String?, _ error: String?) -> Void)?) {
        self.completion = completion
        auth.createUser(withEmail: mail, password: pwd, completion: handleResult(_:_:))
    }
    func signOut() {
        
    }
    
    func handleResult(_ data: AuthDataResult?, _ error: Error?) {
        if error != nil {
            self.completion?(nil, error!.localizedDescription)
        }
        if let uid = data?.user.uid {
            self.completion?(uid, nil)
        }
        
    }
}
