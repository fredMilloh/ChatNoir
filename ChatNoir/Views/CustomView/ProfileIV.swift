//
//  ProfileIV.swift
//  ChatNoir
//
//  Created by fred on 17/11/2020.
//

import UIKit

class ProfileIV: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        isUserInteractionEnabled = true
        contentMode = .scaleToFill
        clipsToBounds = true
    }

}
