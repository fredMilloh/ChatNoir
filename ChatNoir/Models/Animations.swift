//
//  Animations.swift
//  ChatNoir
//
//  Created by fred on 15/11/2020.
//

import UIKit


class Animations {
    
    func center (_ views: [UIView], _ pointX: CGFloat) {
        for view in views {
            view.center.x = pointX
        }
    }
    
    func animateWithSpring(_ view: UIView, _ pointX: CGFloat, _ delay: TimeInterval) {
        let targetAlpha: CGFloat = view.alpha == 0 ? 1.0 : 0.0
        UIView.animate(withDuration: 0.5, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseOut) {
            view.alpha = targetAlpha
            view.center.x = pointX
        }
    }
    
    func moveViews(_ view: UIView, _ y: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            view.center.y += y
        } 

    }
}
