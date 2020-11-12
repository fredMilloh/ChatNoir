//
//  LogController.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import UIKit

class LogController: RootController {
    
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

// MARKS: - Gestion affichage champs
    
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
    
// MARKS: - Alertes sur champs non remplis
    
    @IBAction func validateButton(_ sender: UIButton) {
        if let mail = mailTF.text, mail != "" {
            if let pwd = pwdTF.text, pwd != "" {
                if segmentes.selectedSegmentIndex == 0 {
                    //Authentification
                } else {
                    if let surname = surnameTF.text, surname != "" {
                        if let name = nameTF.text, name != "" {
                            //Création compte
                        } else {
                            //Alert pas de name
                            showAlert("Veuillez entrer votre nom", .error)
                        }
                    } else {
                        //Alert pas de surname
                        showAlert("Veuillez entrer votre prénom", .error)
                    }
                }
            } else {
                //alert pas de pwd
                showAlert("Veuillez entrer votre mot de passe", .error)
            }
        } else {
            // alert pas de mail
            showAlert("Veuillez entrer votre adresse mail", .error)
        }
    }
    
    @IBAction func segmentedChange(_ sender: Any) {
        setupUI()
    }
 
// MARKS: retour clavier
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    

}
