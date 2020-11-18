//
//  HeaderView.swift
//  ChatNoir
//
//  Created by fred on 17/11/2020.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var coverIV: UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var blur: UIVisualEffectView!
    
    var user: User?
    
    func setup(_ user: User?) {
        guard user != nil else { return }
        self.user = user
        nameLbl.text = self.user!.surname + " " + self.user!.name
    }
    
}
