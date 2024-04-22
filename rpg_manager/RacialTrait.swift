//
//  RacialTrait.swift
//  rpg_manager
//
//  Created by Scottyyyyyy on 4/1/24.
//

import Foundation

enum RacialTrait {
    case elf
    case human
    case dwarf
    
    var description: String {
        switch self {
        case .elf:
            return "elf"
        case .human:
            return "human"
        case .dwarf:
            return "dwarf"
        }
    }
}
