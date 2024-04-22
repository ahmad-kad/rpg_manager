//
//  RacialTrait.swift
//  rpg_manager
//
//  Created by Scottyyyyyy on 4/1/24.
//

import Foundation

public enum RacialTrait: CaseIterable, Codable {
    case elf
    case human
    case dwarf
    
    var description: String {
        switch self {
        case .elf:
            return "Elf"
        case .human:
            return "Human"
        case .dwarf:
            return "Dwarf"
        }
    }
}

