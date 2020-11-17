//
//  MainController.swift
//  ChatNoir
//
//  Created by fred on 16/11/2020.
//

import UIKit

class MainController: RootController {
//pour gérer options de tous les controller ( ex: mode nuit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNight()
        MyNotifCenter().receiveNotif("night", self, #selector(setupNight))
    }
    
    @objc func setupNight() {
        view.backgroundColor = UD().getNight() ? .black : .white
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_PROFILE {
            if let next = segue.destination as? ProfileController {
                
            }
        }
    }
    
}
