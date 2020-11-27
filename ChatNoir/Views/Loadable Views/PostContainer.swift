//
//  PostContainer.swift
//  ChatNoir
//
//  Created by fred on 24/11/2020.
//

import UIKit

class PostContainer: LoadableView {

    @IBOutlet weak var userImage: ProfileIV!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postImage: UIImageView! {
        didSet {
            postImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var catText: UILabel!
    @IBOutlet weak var foxButton: UIButton!
    @IBOutlet weak var foxText: UILabel!
    @IBOutlet weak var holderView: RoundedView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    var post: Post!
    var user: User!
 
    let cat_full = UIImage(named: "cat_full")
    let cat_empty = UIImage(named: "cat_empty")
    let fox_full = UIImage(named: "fox_full")
    let fox_empty = UIImage(named: "fox_empty")
    let default_image = UIImage(named: "profile")
    
    func setup(_ post: Post) {
        self.post = post //pour éviter confusion dans la réception des posts
        self.user = nil //on s'assure que le nouvel user soit vide
        userImage.image = default_image //on lui affecte l'image par defaut pour qu'il ne prenne pas celle du post précédent
        //dimensions pour l'image si il y en a une
        let width = self.postImage.frame.width
        let height = self.post.imageUrl == nil ? 0 : width
        self.postImage.frame.size = CGSize(width: width, height: height)
        //hauteur pour le text
        let textSize = SizeUtil().getPostTextSize(self.post.text, width)
        self.postText.frame.size = textSize
        postText.text = self.post.text
        catButton.setImage(getButtonImage(true), for: .normal)
        foxButton.setImage(getButtonImage(false), for: .normal)
        dateLbl.text = setDate()
        categoryLbl.text = self.post.category
        ImageLoader().load(self.post.imageUrl, postImage)
        catText.text = String(self.post.cat.count) + " chat noir"
        foxText.text = String(self.post.fox.count) + " ruse de renard"
        FireDatabase().getUser(self.post.userID) { (u) in
            if let user = u {
                self.user = user
                self.setUser()
            }
        }
        //Transform Category
        let currentCategory = PostCategory(rawValue: self.post.category) // ?? PostCategory.none
        let palette = currentCategory?.getColor()
        holderView.backgroundColor = palette?.background
        dateLbl.textColor = palette?.dateText
        postText.textColor = palette?.mainText
    }
    
    func setUser() {
        guard user != nil else { return }
        //userName.isUserInteractionEnabled = true
        ImageLoader().load(user.imageUrl, userImage)
        userName.text = user.surname + " " + user.name
    }
    
    func setDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let date = Date(timeIntervalSince1970: self.post.date) //on récupére la date
        return formatter.string(from: date)
    }
    
    func getButtonImage(_ cat: Bool) -> UIImage? {
        if let uid = FireAuth().myId() {
            if cat {
                return self.post.cat.contains(uid) ? cat_full : cat_empty
            } else {
                return self.post.fox.contains(uid) ? fox_full : fox_empty
            }
        } else {
            return cat ? cat_empty : fox_empty
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        FireDatabase().addOrRemoveLike(sender.tag == 0, self.post)
    }
    
}
