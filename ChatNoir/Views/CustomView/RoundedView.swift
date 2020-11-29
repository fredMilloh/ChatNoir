//
//  RoundedView.swift
//  ChatNoir
//
//  Created by fred on 12/11/2020.
//

import UIKit

class RoundedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 25
        isUserInteractionEnabled = true
    }
    
}
