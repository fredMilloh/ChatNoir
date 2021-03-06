//
//  MainController.swift
//  ChatNoir
//
//  Created by fred on 16/11/2020.
//

import UIKit

class MainController: RootController {
//pour gérer options de tous les controller fils ( ex: mode nuit)
    
    var photoType: PhotoType = .post
    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNight()
        MyNotifCenter().receiveNotif("night", self, #selector(setupNight))
        MyNotifCenter().receiveNotif(SEGUE_DETAIL, self, #selector(toDetail))
        MyNotifCenter().receiveNotif(SEGUE_PROFILE, self, #selector(toDetail))
    }
    
    @objc func setupNight() {
        view.backgroundColor = UD().getNight() ? DARK_GREY : LIGHT_GREY
    }
    
    @objc func toDetail(notification: Notification) {
        //print("print => \(notification.userInfo)")
        if let notif = notification.userInfo {
            if let last = navigationController?.viewControllers.last { //on recupére le dernier controller afficher
                if let post = notif["post"] as? Post {
                    //on vérifie qu'on n'est pas déjà sur DetailPC, si on appui sur holder du détailPC, on ne veut pas répéter
                    if !last.isKind(of: DetailPostController.self) {
                        last.performSegue(withIdentifier: SEGUE_DETAIL, sender: post)
                        print(post.text)
                    }
                } else if let user = notif["user"] as? User {
                    if !last.isKind(of: ProfileController.self) {
                        last.performSegue(withIdentifier: SEGUE_PROFILE, sender: user)
                    }
                } else if let ref = notif["postId"] as? String {
                    if !last.isKind(of: DetailPostController.self) {
                        last.performSegue(withIdentifier: SEGUE_DETAIL, sender: ref)
                    }
                }
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_PROFILE {
            if let next = segue.destination as? ProfileController {
                next.user = sender as? User
            }
        }
        if segue.identifier == SEGUE_DETAIL {
            if let next = segue.destination as? DetailPostController {
                if let ref = sender as? String {
                    next.ref = ref
                } else if let post = sender as? Post {
                    next.post = post
                }
            }
        }
    }
// MARK: - SetupPicker
    //func pour prendre photo ou accès album - appeler dans les controller qui en ont besoin (ex: ProfileC)
    func setupPicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = false
        imagePicker?.delegate = self
    }
    
    
}

//MARK: - UIImagePickerController

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
            case .post:
                if let controller = self as? FeedController {
                    controller.writePostView?.imageTaken.image = image
                }
            }
        }
    }
 
//MARK: - updateProfile
    
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
