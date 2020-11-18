//
//  ImageLoader.swift
//  ChatNoir
//
//  Created by fred on 18/11/2020.
//

import Foundation
import SDWebImage

class ImageLoader {
    
    func load(_ string: String?, _ view: UIImageView) {
        guard let str = string else { return }
        guard let url = URL(string: str) else { return }
        //on utilise une propriété de SDWebImage .sd_setImage
        view.sd_setImage(with: url, completed: nil)
    }
}
