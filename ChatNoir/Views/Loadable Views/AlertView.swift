//
//  AlertView.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import UIKit

class AlertView: LoadableView {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    var type: AlertType = .error
    var controller: UIViewController?
    var imagePicker: UIImagePickerController?
    
    func setupError(_ message: String) {
        titleLbl.text = "Une erreur est survenue"
        messageLbl.text = message
        btn1.isHidden = true
        btn2.isHidden = true
    }
    
    func setupDisconnect(_ controller: UIViewController) {
        self.controller = controller
        self.type = .disconnect
        titleLbl.text = "Se déconnecter"
        messageLbl.text = "Etes-vous sûr de vouloir vous déconnecter ?"
        btn1.isHidden = false
        btn2.isHidden = false
        btn1.setTitle("NON", for: .normal)
        btn2.setTitle("OUI", for: .normal)
    }
    
    func setupCamera(_ controller: MainController, _ imagePicker: UIImagePickerController) {
        self.type = .camera
        self.controller = controller
        self.imagePicker = imagePicker
        titleLbl.text = "Prenez un photo"
        messageLbl.text = "Quel est le média que vous voulez utiliser ?"
        btn1.isHidden = false
        btn2.isHidden = false
        btn1.setImage(UIImage(named: "camera"), for: .normal)
        btn2.setImage(UIImage(named: "gallery"), for: .normal)
    }
    
    func handleButton(_ isButton1: Bool) {
        switch type {
        case .disconnect:
            if isButton1 {
                MyNotifCenter().post("cancel", nil)
            } else {
                if FireAuth().signOut() {
                    controller?.navigationController?.popToRootViewController(animated: true)
                } else {
                    MyNotifCenter().post("cancel", nil)
                }
            }
        case .camera:
            guard imagePicker != nil else { return }
            imagePicker!.sourceType = isButton1 ? .camera : .photoLibrary
            controller?.present(imagePicker!, animated: true, completion: nil)
        default: break
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0: MyNotifCenter().post("cancel", nil)
        case 1: handleButton(true)
        case 2: handleButton(false)
        default: break
        }
    }
        
    
    
}
