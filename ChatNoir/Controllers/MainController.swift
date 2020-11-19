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
            case .cover, .profile: updateProfile(image)
            case .post: print("post")
            }
        }
    }
    
    func updateProfile(_ image: UIImage) {
        guard let uid = FireAuth().myId() else { return }
        let ref = photoType == .cover ? FireStorage().userCover(uid) : FireStorage().userProfile(uid)
        FireStorage().sendImageToFirebase(ref, image) { (string, error) in
            if error != nil { print(error!.localizedDescription) }
            if let urlString = string {
                let key = self.photoType == .cover ? KEY_COVERURL : KEY_IMAGEURL
                FireDatabase().updateUser(uid, data: [key: urlString])
            }
        }
    }
}
