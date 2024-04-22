//
//  barbarian.swift
//  rpg_manager
//
//  Created by ahmad kaddoura on 4/19/24.
//

import Foundation
import SwiftData

class Barbarian: Actor {
    var rageLevel: Int = 0
    var weapon: String = ""
    
    init(name: String, level: Int, race: RacialTrait, isAlive: Bool, isActive: Bool) {
        super.init(name: name, actorClass: .barbarian, level: level, mana: 0, maxHP: 10, currentHP: 10, armorClass: 5, experience: 0, race: race, isAlive: isAlive, isActive: isActive)
        
        self.rageLevel = 0
        self.weapon = "Axe"
    }
    
    required init(backingData: any SwiftData.BackingData<Actor>) {
        fatalError("init(backingData:) has not been implemented")
    }
    
    func increaseRage() {
        rageLevel += 1
    }
    
    
    override func attack() -> Int{
        print("\(getName()) attacks with \(weapon)!")
        rageLevel += 1
        return rageLevel + super.getLevel() * Int.random(in:1..<5)
    }
}
