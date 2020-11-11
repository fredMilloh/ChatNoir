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
    }
    
    func showAlert(_ message: String?, _ type: AlertType) {
        if alertView != nil {
            closeAlert()
        }
        alertView = AlertView(frame: view.bounds)
        view.addSubview(alertView!)
    }
    func closeAlert() {
        alertView?.removeFromSuperview()
        alertView = nil
    }

}
