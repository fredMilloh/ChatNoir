//
//  DetailPostController.swift
//  ChatNoir
//
//  Created by fred on 29/11/2020.
//

import UIKit

class DetailPostController: MainController {
    
    @IBOutlet weak var postContainer: PostContainer!
    @IBOutlet weak var cancelButton: UIButton!
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        if post != nil {
            postContainer.setup(post!)
            monitorUpdates(post!.uid)
        } else {
            // Notifications
        }

    }
    
    func monitorUpdates(_ id: String) {
        let ref = FireDatabase().postsCollection.document(id)
        ref.addSnapshotListener { (snap, error) in
            if let document = snap {
                self.post = Post(document)
                self.postContainer.setup(self.post!)
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
