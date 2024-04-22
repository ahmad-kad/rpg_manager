//
//  PendingActor.swift
//  rpg_manager
//
//  Created by Scottyyyyyy on 5/8/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class PendingActor {
    
    private var pendingName: String = ""
    
    private var pendingActorClass: CharacterClass
    
    private var pendingLevel: String = ""
    private var pendingMana: String = ""
    private var pendingMaxHP: String = ""
    private var pendingCurrentHP: String = ""
    private var pendingArmorClass: String = ""
    private var pendingExperience: String = ""
    
    private var pendingRace: RacialTrait
    
    private var pendingIsAlive: Bool = false
    private var pendingIsActive: Bool = false
    
    init(pendingName: String, pendingActorClass: CharacterClass, pendingLevel: String, pendingMana: String, pendingMaxHP: String, pendingCurrentHP: String, pendingArmorClass: String, pendingExperience: String, pendingRace: RacialTrait, pendingIsAlive: Bool, pendingIsActive: Bool) {
        self.pendingName = pendingName
        self.pendingActorClass = pendingActorClass
        self.pendingLevel = pendingLevel
        self.pendingMana = pendingMana
        self.pendingMaxHP = pendingMaxHP
        self.pendingCurrentHP = pendingCurrentHP
        self.pendingArmorClass = pendingArmorClass
        self.pendingExperience = pendingExperience
        self.pendingRace = pendingRace
        self.pendingIsAlive = pendingIsAlive
        self.pendingIsActive = pendingIsActive
    }
    
    func attack() -> Int {
        if let pendingLevelInt = Int(pendingLevel) {
            return pendingLevelInt * Int.random(in: 1..<5)
        } else {
            return 0
        }
    }
    
    func characterIsAlive() -> Bool {
        return pendingIsAlive == true
    }
    
    func getPendingName() -> String {
        return pendingName
    }
    func setPendingName(pendingName: String) {
        self.pendingName = pendingName
    }


    func getPendingActorClass() -> CharacterClass {
        return pendingActorClass
    }
    func setPendingActorClass(pendingActorClass: CharacterClass) {
        self.pendingActorClass = pendingActorClass
    }


    func getPendingLevel() -> String {
        return pendingLevel
    }
    func setPendingLevel(pendingLevel: String) {
        self.pendingLevel = pendingLevel
    }


    func getPendingMana() -> String {
        return pendingMana
    }
    func setPendingMana(pendingMana: String) {
        self.pendingMana = pendingMana
    }


    func getPendingMaxHP() -> String {
        return pendingMaxHP
    }
    func setPendingMaxHP(pendingMaxHP: String) {
        self.pendingMaxHP = pendingMaxHP
    }


    func getPendingCurrentHP() -> String {
        return pendingCurrentHP
    }
    func setPendingCurrentHP(pendingCurrentHP: String) {
        self.pendingCurrentHP = pendingCurrentHP
    }


    func getPendingArmorClass() -> String {
        return pendingArmorClass
    }
    func setPendingArmorClass(pendingArmorClass: String) {
        self.pendingArmorClass = pendingArmorClass
    }


    func getPendingExperience() -> String {
        return pendingExperience
    }
    func setPendingExperience(pendingExperience: String) {
        self.pendingExperience = pendingExperience
    }

    func getPendingRace() -> RacialTrait {
        return pendingRace
    }
    func setPendingRace(pendingRace: RacialTrait) {
        self.pendingRace = pendingRace
    }
}

