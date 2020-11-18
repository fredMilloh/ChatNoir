//
//  ProfileController.swift
//  ChatNoir
//
//  Created by fred on 17/11/2020.
//

import UIKit

class ProfileController: MainController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var headerView: HeaderView?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = HeaderLayout()
        getUser()
        setupPicker()
    }
    
    func getUser() {
        FireDatabase().getMe { (user) in
            if let new = user {
                print("Nouveau => " + new.name)
                self.user = new
                self.collectionView.reloadData()
            }
        }
    }

}
extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: POST_ID, for: indexPath) as? PostCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
    
    //Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_ID, for: indexPath) as? HeaderView
        headerView?.setup(user, self)
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -44 {
            headerView?.blur.isHidden = false
        } else {
            headerView?.blur.isHidden = true
        }
    }
    
}
