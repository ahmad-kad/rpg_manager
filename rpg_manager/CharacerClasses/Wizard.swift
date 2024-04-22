//
//  wizard.swift
//  rpg_manager
//
//  Created by ahmad kaddoura on 4/19/24.
//

import Foundation
class Wizard: Actor {
    var spellBook: [String] = []
    
    init(name: String, level: Int, race: RacialTrait, isAlive: Bool, isActive: Bool) {
        super.init(name: name, actorClass: .wizard, level: level, mana: 20, maxHP: 8, currentHP: 8, armorClass: 3, experience: 0, race: race, isAlive: isAlive, isActive: isActive)
        
        self.spellBook = ["Fireball", "Magic Missile"]
    }
    
    // Method to cast a spell
    func castSpell(spell: String) {
        if spellBook.contains(spell) {
            print("\(getName()) casts \(spell)!")
        } else {
            print("\(getName()) doesn't know \(spell).")
        }
    }
    
    override func attack() -> Int{
        return super.getLevel() * Int.random(in: 1..<3)
    }
}
