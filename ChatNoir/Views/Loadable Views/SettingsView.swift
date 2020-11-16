//
//  SettingsView.swift
//  ChatNoir
//
//  Created by fred on 16/11/2020.
//

import UIKit

class SettingsView:LoadableView {

    @IBOutlet weak var notifSwitch: UISwitch!
    @IBOutlet weak var nightSwitch: UISwitch!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupData()
    }
    
    
    
    //positionner le switch en fonction du mode choisi
    func setupData() {
        nightSwitch.setOn(UD().getNight(), animated: true)
    }

    @IBAction func cancelButton(_ sender: Any) {
        Animations().moveViews(self, self.frame.midY * 2, true)
    }
    
    @IBAction func notifSwitchPressed(_ sender: Any) {
    }
    
    @IBAction func nightSwitchPressed(_ sender: Any) {
        UD().setNight()
        setupData()
        MyNotifCenter().post("night", nil)
    }
}
