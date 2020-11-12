//
//  RoundedButton.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import UIKit

class RoundedButton: UIButton {

    // initialisation
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
    }
}
