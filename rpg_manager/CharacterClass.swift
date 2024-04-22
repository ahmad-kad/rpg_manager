//
//  CharacterClass.swift
//  rpg_manager
//
//  Created by Scottyyyyyy on 4/1/24.
//

import Foundation

enum CharacterClass {
    
    case barbarian
    case ranger
    case wizard
    
    var description: String {
        switch self {
        case .barbarian:
            return "Barbarian"
        case .ranger:
            return "Ranger"
        case .wizard:
            return "Wizard"
        }
    }
}

