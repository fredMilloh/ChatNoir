//
//  PostCell.swift
//  ChatNoir
//
//  Created by fred on 17/11/2020.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: PostContainer!
    
    var post: Post!
    
    func setup(_ post: Post) {
        self.post = post
        containerView.setup(self.post)
    }
    
}
