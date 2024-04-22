//
//  ranger.swift
//  rpg_manager
//
//  Created by ahmad kaddoura on 4/19/24.
//

import Foundation
import SwiftData

class Ranger: Actor {
    var trackingSkillLevel: Int
    var favoredTerrain: String
    
    init(name: String, level: Int, race: RacialTrait, isAlive: Bool, isActive: Bool, trackingSkillLevel: Int, favoredTerrain: String) {
        self.trackingSkillLevel = trackingSkillLevel
        self.favoredTerrain = favoredTerrain
        super.init(name: name, actorClass: .ranger, level: level, mana: 0, maxHP: 10, currentHP: 10, armorClass: 5, experience: 0, race: race, isAlive: isAlive, isActive: isActive)
    }
    
    required init(backingData: any SwiftData.BackingData<Actor>) {
        fatalError("init(backingData:) has not been implemented")
    }
    
    // Method to track a target
    func trackTarget(target: String) {
        print("\(getName()) uses their tracking skills to follow \(target)'s trail.")
    }
    
    override func attack() -> Int {
        return super.getLevel() * Int.random(in: 1..<4)
    }
}
