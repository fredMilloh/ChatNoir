//
//  MainController.swift
//  ChatNoir
//
//  Created by fred on 16/11/2020.
//

import UIKit

class MainController: RootController {
//pour gérer options de tous les controller ( ex: mode nuit)
    
    var photoType: PhotoType = .post
    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNight()
        MyNotifCenter().receiveNotif("night", self, #selector(setupNight))
    }
    
    func setupPicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = false
        imagePicker?.delegate = self
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
extension MainController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        closeAlert()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        closeAlert()
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            switch photoType {
            case .post: print("post")
            case .profile: print("profile")
            case .cover: print("cover")
            }
        }
    }
}
