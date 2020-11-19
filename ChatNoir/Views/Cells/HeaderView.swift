//
//  HeaderView.swift
//  ChatNoir
//
//  Created by fred on 17/11/2020.
//

import UIKit
import SDWebImage

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var profileIV: ProfileIV!
    @IBOutlet weak var coverIV: UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var blur: UIVisualEffectView!
    
    var user: User?
    var controller: ProfileController?
    
    func setup(_ user: User?, _ controller: ProfileController) {
        self.controller = controller
        guard user != nil else { return }
        self.user = user
        nameLbl.text = self.user!.surname + " " + self.user!.name
        ImageLoader().load(self.user!.imageUrl, profileIV)
        ImageLoader().load(self.user!.coverUrl, coverIV)
    }
    //func pour gérer le toucher écran au niveau du header
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //on vérifie que l'écran a été touché, donc qu'il y a un (first) "touches" dans le Set<UITouch>
        guard let touch = touches.first else { return }
        guard let myUser = user else { return }
        //on vérifie que l'user est bien le notre (pas un autre profil), pour modifier header infos
        guard let myId = FireAuth().myId(), myId == myUser.uid else { return }
        guard controller != nil else { return }
        guard controller!.imagePicker != nil else { return }
        //on affecte un évenement a l'élement touchable du header
        if touch.view == profileIV {
            //Montrer Alerte pour changer Profil
            controller!.photoType = .profile
            controller!.cameraAlert(controller!.imagePicker!, controller!)
        } else if touch.view == nameLbl {
            //Alerte pour changer le nom
            controller?.showAlert(nil, user, .changeName)
        } else {
            // Alerte pour cover
            controller!.photoType = .cover
            controller!.cameraAlert(controller!.imagePicker!, controller!)
        } //pour acceder au Alerte, on rajoute un argument controller à setup()
    }
    
}
