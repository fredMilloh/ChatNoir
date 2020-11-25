//
//  FeedController.swift
//  ChatNoir
//
//  Created by fred on 13/11/2020.
//

import UIKit
import Firebase

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
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        MyNotifCenter().receiveNotif("disconnect", self, #selector(disconnect))
        setupPicker()
        FireDatabase().getPosts(.none, _isFavorite: false) { (posts, error) in
            if let newPosts = posts {
                self.posts = newPosts
                self.collectionView.reloadData()
                //pour TEST dans console = text des posts triés par date
                //newPosts.forEach { (post) in
                //   print(post.text)
                //}
            }
        }
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
        //on transfére l'anim dans WritePostView
        //Animations().moveViews(writePostView!, -self.view.frame.height * 1.5 + 100, false)
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

//MARK: - Category UIPickerViewDelegate DataSource

extension FeedController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PostCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return "Row number => \(row)" // affichera dans le picker Row number => 0 puis Row number => 1 ... 5 fois
        return PostCategory.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("Row Chosen => \(row)")
        if writePostView != nil {
            writePostView?.selectedCategory = PostCategory.allCases[row] //pour passer la selection du picker
        }
    }
}

//MARK: - UICollectionViewDelegate, FlowLayout, DataSource

extension FeedController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: POST_ID, for: indexPath) as? PostCell {
            cell.setup(posts[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let post = posts[indexPath.item]
        let width = collectionView.frame.width
        let elementWidth = width - 50
        var baseHeight: CGFloat = 130
        baseHeight += SizeUtil().getPostTextSize(post.text, elementWidth).height
        if post.imageUrl != nil {
            baseHeight += elementWidth
        }
        return CGSize(width: width, height: baseHeight)
    }
    
}
