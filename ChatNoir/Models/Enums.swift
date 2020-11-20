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
}
