//
//  WritePostVIew.swift
//  ChatNoir
//
//  Created by fred on 20/11/2020.
//

import UIKit

class WritePostView: LoadableView {

    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageTaken: UIImageView!
    
    var controller: FeedController!
    var heightToMove: CGFloat!
    var selectedCategory = PostCategory.none
    
    func openAndSetup(_ controller: FeedController) {
        self.controller = controller
        self.heightToMove = -self.controller.view.frame.height * 1.5 + 100
        Animations().moveViews(self, heightToMove , false)
        pickerView.delegate = self.controller // on veut que ce soit FeedController qui gére
        pickerView.dataSource = self.controller
    }
    
    func close() {
        Animations().moveViews(self, -heightToMove, true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        close()
    }
    
    
    
    @IBAction func sendPressed(_ sender: Any) {
        guard let uid = FireAuth().myId() else { return }
        if imageTaken.image != nil || descriptionTV.text != "" {
            close() // on envoi le post, la fenêtre se ferme
            let emptyArray: [String] = []
            let date = Date().timeIntervalSince1970
            var data: [String: Any] = [
                KEY_TEXT: descriptionTV.text!,
                KEY_CATEGORY: selectedCategory.rawValue,
                KEY_DATE: date,
                KEY_CAT: emptyArray,
                KEY_FOX: emptyArray,
                KEY_UID: uid
            ]
            if imageTaken.image == nil {
                FireDatabase().addPost(data)
                print("post envoyé")
            } else {
                let ref = FireStorage().post(uid, timeStamp: date)
                FireStorage().sendImageToFirebase(ref, imageTaken.image!) { (string, error) in
                    if let urlString = string {
                        data[KEY_IMAGEURL] = urlString
                        FireDatabase().addPost(data)
                        print("post envoyé")
                    }
                }
            }
        } else {
            controller.showAlert("Il n'y a pas de photo ou post à envoyer", nil, .error)
        }
    }
    
    @IBAction func takePicture(_ sender: UIButton) {
        guard let ip = controller.imagePicker else { return }
        controller.photoType = .post
        switch sender.tag {
        case 0:
            ip.sourceType = .camera
            controller.present(ip, animated: true, completion: nil)
        case 1:
            ip.sourceType = .photoLibrary
            controller.present(ip, animated: true, completion: nil)
        default: break
        }
    }
    
    
}

