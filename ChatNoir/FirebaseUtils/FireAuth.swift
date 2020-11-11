//
//  FireAuth.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import Foundation
import Firebase

class FireAuth {
    // pour vérifier si on est identifier
    func isAuth() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
}
