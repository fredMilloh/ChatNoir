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

// MARK: - Gestion affichage champs
    
    func setupUI() {
        if FireAuth().isAuth() {
            // si true on va a la seconde page
            toMain()
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
    
// MARK: - Alertes sur champs non remplis
    
    @IBAction func validateButton(_ sender: UIButton) {
        if let mail = mailTF.text, mail != "" {
            if let pwd = pwdTF.text, pwd != "" {
                if segmentes.selectedSegmentIndex == 0 {
                    //Authentification
                    FireAuth().signIn(mail, pwd) { (uid, error) in
                        if error != nil {
                            self.showAlert(error, nil, .error)
                        }
                        if uid != nil {
                            //vers controller suivant
                            self.toMain()
                        }
                    }
                } else {
                    if let surname = surnameTF.text, surname != "" {
                        if let name = nameTF.text, name != "" {
                            //Création compte
                            FireAuth().createUser(mail, pwd) { (uid, error) in
                                if error != nil {
                                    self.showAlert(error, nil, .error)
                                }
                                if uid != nil {
                                    let data: [String: Any] = [KEY_NAME: name, KEY_SURNAME: surname, KEY_UID: uid!]
                                    FireDatabase().addUser(uid!, data: data)
                                    self.toMain()
                                }
                            }
                        } else {
                            //Alert pas de name
                            showAlert(errorEmpty("nom"), nil, .error)
                        }
                    } else {
                        //Alert pas de surname
                        showAlert(errorEmpty("prénom"), nil, .error)
                    }
                }
            } else {
                //alert pas de pwd
                showAlert(errorEmpty("mot de passe"), nil, .error)
            }
        } else {
            // alert pas de mail
            showAlert(errorEmpty("adresse mail"), nil, .error)
        }
    }
    
    @IBAction func segmentedChange(_ sender: Any) {
        setupUI()
    }
    
    func toMain() {
        performSegue(withIdentifier: SEGUE_APP, sender: nil)
    }
 
// MARK: retour clavier
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    

}
