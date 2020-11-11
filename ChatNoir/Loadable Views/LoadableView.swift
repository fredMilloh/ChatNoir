//
//  LoadableView.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import UIKit

class LoadableView: UIView {

    var viewFromXib: UIView?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewFromXib = loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewFromXib = loadView()
    }
    
    func loadView() -> UIView {
        let name = String(describing: type(of: self)) //on récupére en string le nom exact de la vue charger
        if let v = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView {
            self.addSubview(v)
            v.frame = bounds
            v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return v
        } else {
            return UIView()
        }
    }
}
