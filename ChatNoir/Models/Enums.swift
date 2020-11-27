//
//  Enums.swift
//  ChatNoir
//
//  Created by fred on 11/11/2020.
//

import Foundation

enum AlertType {
    case error
    case camera
    case disconnect
    case changeName
}

enum PhotoType {
    case profile
    case cover
    case post 
}

enum PostCategory: String, CaseIterable {      //permet de retourner un row en string et l'enum en array
    case none = "Aucune catégorie"
    case job = "Travail"
    case family = "Famille"
    case naughty = "Coquin"
    case pets = "Animaux de compagnie"
    case holidays = "Vacances"
    case friends = "Amis"
    
    func getColor() -> ColorPalette {
        switch self {
        case .none: return ColorPalette(background: TURQUOISE, mainText: DARK_GREY, dateText: RED)
        case .family: return ColorPalette(background: PURPLE, mainText: LIGHT_GREY, dateText: RED)
        case .friends: return ColorPalette(background: SUNFLOWER, mainText: DARK_GREY, dateText: RED)
        case .holidays: return ColorPalette(background: TURQUOISE, mainText: LIGHT_GREY, dateText: RED)
        case .job: return ColorPalette(background: RIVER_BLUE, mainText: LIGHT_GREY, dateText: RED)
        case .naughty: return ColorPalette(background: RED, mainText: LIGHT_GREY, dateText: RIVER_BLUE)
        case .pets: return ColorPalette(background: EMERALD_GREEN, mainText: LIGHT_GREY, dateText: RED)
        }
    }
}
