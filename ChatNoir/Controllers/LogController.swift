//
//  LogController.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import UIKit

class LogController: UIViewController {
    
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var segmentes: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateVisible(false, mailTF)
        updateVisible(false, pwdTF)
        updateVisible(false, surnameTF)
        updateVisible(false, nameTF)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI() {
        if FireAuth().isAuth() {
            // si true on va a la seconde page
            print("Auth == true")
        } else {
            // on doit s'authentifier
            updateVisible(true, mailTF)
            updateVisible(true, pwdTF)
            let bool = segmentes.selectedSegmentIndex != 0
            updateVisible(bool, surnameTF)
            updateVisible(bool, nameTF)
        }
    }
    
    func updateVisible (_ bool: Bool, _ view: UIView) {
        view.isHidden = !bool
    }
    
    @IBAction func validateButton(_ sender: UIButton) {
    }
    
    @IBAction func segmentedChange(_ sender: Any) {
        setupUI()
    }
    
    
    

}
