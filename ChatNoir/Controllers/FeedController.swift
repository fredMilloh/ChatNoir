//
//  FeedController.swift
//  ChatNoir
//
//  Created by fred on 13/11/2020.
//

import UIKit

class FeedController: MainController {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuView: RoundedView! // pour lui appliquer arrondi
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var notifButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var gearsButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet var listButton: [UIButton]!
    
    
    var isMenuOpen = false
    var baseFrame: CGRect?
    
    var settingsView: SettingsView?
    var writePostView: WritePostView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyNotifCenter().receiveNotif("disconnect", self, #selector(disconnect))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseFrame = menuView.frame
    }
    
    func openMenu() {
        menuView.translatesAutoresizingMaskIntoConstraints = true
        menuButton.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.menuView.frame = CGRect(x: 20, y: self.menuView.frame.minY, width: self.view.frame.width - 40, height: 50)
        } completion: { (success) in
            let pointX = self.menuView.center.x
            Animations().center(self.listButton, pointX)
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
                        //creation d'une méthode dans Animations pour simplifier code
                        Animations().animateWithSpring(self.pencilButton, self.menuView.frame.minX + 21, 0)
                        Animations().animateWithSpring(self.gearsButton, self.menuView.frame.maxX - 60, 0.1)
                        Animations().animateWithSpring(self.notifButton, self.menuView.frame.width * 0.25 + 21, 0.2)
                        Animations().animateWithSpring(self.profileButton, self.menuView.frame.width * 0.75 - 21, 0.3)
                    }

                }

            }

        }
        isMenuOpen = true
    }
    
    func closeMenu(_ tag: Int) {
        UIView.animate(withDuration: 1.0) {
            let pointX = self.menuView.center.x
            Animations().animateWithSpring(self.pencilButton, pointX, 0.3)
            Animations().animateWithSpring(self.gearsButton, pointX, 0.2)
            Animations().animateWithSpring(self.notifButton, pointX, 0.1)
            Animations().animateWithSpring(self.profileButton, pointX, 0.0)
            self.menuButton.transform = CGAffineTransform.identity
        } completion: { (success) in
            UIView.animate(withDuration: 0.25) {
                self.menuView.frame = self.baseFrame ?? CGRect()
            } completion: { (success) in
                self.isMenuOpen = false
                self.removeExisting()
                switch tag {
                case 1: self.showWrite()
                case 2: print("Notif")
                case 3: self.performSegue(withIdentifier: SEGUE_PROFILE, sender: nil)
                case 4: self.showSettings()
                default: break
                }
            }

        }
    }
    
    @objc func disconnect() {
        showAlert(nil, nil, .disconnect)
    }
    
    //pour supprimer les vues déjà existantes
    func removeExisting() {
        if writePostView != nil {
            writePostView?.removeFromSuperview()
            writePostView = nil
        }
        if settingsView != nil {
            settingsView?.removeFromSuperview()
            settingsView = nil
        }
    }
    
    func showWrite() {
        let frame = CGRect(x: 20, y: self.view.frame.height * 1.5, width: self.view.frame.width - 40, height: self.view.frame.height - 200)
        writePostView = WritePostView(frame: frame)
        view.addSubview(writePostView!)
        writePostView?.openAndSetup(self)
    }
    
    func showSettings() {
        let settingsFrame = CGRect(x: 20, y: self.view.frame.height * 1.5, width: self.view.frame.width - 40, height: 250)
        settingsView = SettingsView(frame: settingsFrame)
        view.addSubview(settingsView!)
        Animations().moveViews(settingsView!, -self.view.frame.height, false)
    }
    @IBAction func segmentedPressed(_ sender: Any) {
    }
    @IBAction func menuPressed(_ sender: UIButton) {
        isMenuOpen ? closeMenu(sender.tag) : openMenu()
    }
    
    
}
