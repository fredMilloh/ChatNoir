//
//  Constants.swift
//  ChatNoir
//
//  Created by fred on 13/11/2020.
//

import Foundation

//Segues
let SEGUE_APP = "ToApp"
let SEGUE_PROFILE = "ToProfile"

//Identifiers
let HEADER_ID = "HeaderView"
let POST_ID = "PostCell"
let NOTIF_ID = "NotifCell"
 
//Keys
let KEY_NAME = "name"
let KEY_SURNAME = "surname"
let KEY_UID = "uid"

//UD
let UD_NIGHT = "night"

//Functions
func errorEmpty(_ string: String) -> String {
    return "Veuillez entrer votre " + string
}
