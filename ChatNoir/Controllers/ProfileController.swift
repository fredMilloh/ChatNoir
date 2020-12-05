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
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = HeaderLayout()
        getUser()
        setupPicker()
    }
    
    func getUser() {
        if user != nil {
            FireDatabase().getUser(user!.uid) { (u) in
                if let new = u {
                    self.user = new
                    self.observePost()
                    self.collectionView.reloadData()
                }
            }
        } else {
            FireDatabase().getMe { (user) in
                if let new = user {
                    print("Nouveau => " + new.name)
                    self.user = new
                    self.observePost()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func observePost() {
        guard let u = user else { return }
        FireDatabase().getPostsFrom(u.uid) { (p, e) in
            if let newPosts = p {
                self.posts = newPosts
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // cell
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
        return SizeUtil().getPostSize(posts[indexPath.item], collectionView.frame.width - 10)
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
