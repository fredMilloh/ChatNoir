//
//  RootController.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import UIKit

class RootController: UIViewController {
    
    var alertView: AlertView?

    override func viewDidLoad() {
        super.viewDidLoad()
        MyNotifCenter().receiveNotif("cancel", self, #selector(closeAlert))
    }
    
    func showAlert(_ message: String?, _ user: User?, _ type: AlertType) {
        if alertView != nil {
            closeAlert()
        }
        alertView = AlertView(frame: view.bounds)
        switch type {
        case .error: alertView?.setupError(message ?? "")
        case .disconnect: alertView?.setupDisconnect(self)
        case .changeName: alertView?.setupName(user)
        default: break
        }
        view.addSubview(alertView!)
    }
    
    func cameraAlert(_ picker: UIImagePickerController, _ controller: MainController) {
        if alertView != nil {
            closeAlert()
        }
        alertView = AlertView(frame: view.bounds)
        alertView?.setupCamera(controller, picker)
        view.addSubview(alertView!)
    }
    
    @objc func closeAlert() {
        alertView?.removeFromSuperview()
        alertView = nil
    }

}
