//
//  Constants.swift
//  ChatNoir
//
//  Created by fred on 13/11/2020.
//

import UIKit

//Segues
let SEGUE_APP = "ToApp"
let SEGUE_PROFILE = "ToProfile"
let SEGUE_DETAIL = "ToDetail"
let SEGUE_NOTIF = "ToNotif"

//Identifiers
let HEADER_ID = "HeaderView"
let POST_ID = "PostCell"
let NOTIF_ID = "NotifCell"
 
//Keys
let KEY_NAME = "name"
let KEY_SURNAME = "surname"
let KEY_UID = "uid"
let KEY_IMAGEURL = "imageUrl"
let KEY_COVERURL = "coverUrl"
let KEY_TEXT = "text"
let KEY_CATEGORY = "category"
let KEY_DATE = "date"
let KEY_CAT = "cat"
let KEY_FOX = "fox"
let KEY_REF = "ref"
let KEY_SEEN =  "seen"

//UD
let UD_NIGHT = "night"

//Colors
let TURQUOISE = UIColor(red: 26 / 255, green: 188 / 255, blue: 156 / 255, alpha: 1)
let SUNFLOWER = UIColor(red: 241 / 255, green: 196 / 255, blue: 15 / 255, alpha: 1)
let EMERALD_GREEN = UIColor(red: 46 / 255, green: 204 / 255, blue: 113 / 255, alpha: 1)
let CARROT = UIColor(red: 230 / 255, green: 126 / 255, blue: 34 / 255, alpha: 1)
let RIVER_BLUE = UIColor(red: 52 / 255, green: 152 / 255, blue: 219 / 255, alpha: 1)
let RED = UIColor(red: 231 / 255, green: 76 / 255, blue:  60 / 255, alpha: 1)
let PURPLE = UIColor(red: 155 / 255, green: 89 / 255, blue: 182 / 255, alpha: 1)
let LIGHT_GREY = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
let DARK_GREY = UIColor(red:  44 / 255, green: 62 / 255, blue: 80 / 255, alpha: 1)
let GREY = UIColor(red: 149 / 255, green: 165 / 255, blue: 166 / 255, alpha: 1)

//Functions
func errorEmpty(_ string: String) -> String {
    return "Veuillez entrer votre " + string
}

// Typealiases

typealias UserCompletion = (_ user: User?) -> Void
typealias ImageUploadCompletion = (_ urlString: String?, _ error: Error?) -> Void
typealias NotifCompletion = (_ notifs: [InsideNotification]?) -> Void
