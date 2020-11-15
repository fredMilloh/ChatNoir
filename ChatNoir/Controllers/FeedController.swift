//
//  FeedController.swift
//  ChatNoir
//
//  Created by fred on 13/11/2020.
//

import UIKit

class FeedController: UIViewController {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var notifButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var gearsButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var isMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func openMenu() {
        menuView.translatesAutoresizingMaskIntoConstraints = true
        menuButton.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.menuView.frame = CGRect(x: 20, y: self.menuView.frame.minY, width: self.view.frame.width - 40, height: 50)
        } completion: { (success) in
            UIView.animate(withDuration: 0.25) {
                self.menuButton.alpha = 1
                self.menuButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            } completion: { (success) in
                UIView.animate(withDuration: 0.25) {
                    self.menuButton.transform = CGAffineTransform.identity
                } completion: { (success) in
                    UIView.animate(withDuration: 0.25) {
                        self.menuButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
                    } completion: { (success) in
                        //
                    }

                }

            }

        }




    }
    
    func closeMenu() {
        
        
    }
    @IBAction func segmentedPressed(_ sender: Any) {
    }
    @IBAction func menuPressed(_ sender: UIButton) {
        isMenuOpen ? closeMenu() : openMenu()
    }
    
    
}
