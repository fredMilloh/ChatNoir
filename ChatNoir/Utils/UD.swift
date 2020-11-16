//
//  UD.swift
//  ChatNoir
//
//  Created by fred on 16/11/2020.
//

import Foundation


class UD {
    let def = UserDefaults.standard
    
    func setNight() {
        def.set(!getNight(), forKey: UD_NIGHT)
        
    }
    
    func getNight() -> Bool {
        return def.bool(forKey: UD_NIGHT)
    }
}
