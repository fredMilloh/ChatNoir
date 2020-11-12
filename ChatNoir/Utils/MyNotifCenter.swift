//
//  NotificationCenter.swift
//  ChatNoir
//
//  Created by fred on 12/11/2020.
//

import UIKit

class MyNotifCenter {
    
    let notif = NotificationCenter.default
    
    func post(_ name: String, _ userInfos: [AnyHashable: Any]?) {
        notif.post(name: Notification.Name(name), object: nil, userInfo: userInfos)
    }
    
    func receiveNotif(_ name: String, _ observer: UIViewController, _ action: Selector) {
        notif.addObserver(observer, selector: action, name: Notification.Name(name), object: nil)
    }
    
}
