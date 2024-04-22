//
//  Actor.swift
//  rpg_manager
//
//  Created by Phuc Thinh Nguyen on 4/1/24.
//

import Foundation
import SwiftData

@Model
class Actor {
    private var name: String = ""
    
    private var actorClass: CharacterClass
    
    private var level: Int = 0
    private var mana: Int = 0
    private var maxHP: Int = 0
    private var currentHP: Int = 0
    private var armorClass: Int = 0
    private var experience: Int = 0
    
    private var race: RacialTrait
    
    private var isAlive: Bool = false
    private var isActive: Bool = false
    
    init(name: String, actorClass: CharacterClass, level: Int, mana: Int, maxHP: Int, currentHP: Int, armorClass: Int, experience: Int, race: RacialTrait, isAlive: Bool, isActive: Bool) {
        self.name = name
        self.actorClass = actorClass
        self.level = level
        self.mana = mana
        self.maxHP = maxHP
        self.currentHP = currentHP
        self.armorClass = armorClass
        self.experience = experience
        self.race = race
        self.isAlive = isAlive
        self.isActive = isActive
    }
    
    func attack() -> Int{
        return self.level * Int.random(in: 1..<5)
    }
    
    func characterIsAlive() -> Bool {
        return isAlive == true
    }
    
    func getName() -> String {
        return name
    }
    func setName(name: String) {
        self.name = name
    }


    func getActorClass() -> CharacterClass {
        return actorClass
    }
    func setActorClass(actorClass: CharacterClass) {
        self.actorClass = actorClass
    }


    func getLevel() -> Int {
        return level
    }
    func setLevel(level: Int) {
        self.level = level
    }


    func getMana() -> Int {
        return mana
    }
    func setMana(mana: Int) {
        self.mana = mana
    }


    func getMaxHP() -> Int {
        return maxHP
    }
    func setMaxHP(maxHP: Int) {
        self.maxHP = maxHP
    }


    func getCurrentHP() -> Int {
        return currentHP
    }
    func setCurrentHP(currentHP: Int) {
        self.currentHP = currentHP
    }


    func getArmorClass() -> Int {
        return armorClass
    }
    func setArmorClass(armorClass: Int) {
        self.armorClass = armorClass
    }


    func getExperience() -> Int {
        return experience
    }
    func setExperience(experience: Int) {
        self.experience = experience
    }

    func getRace() -> RacialTrait {
        return race
    }
    func setRace(race: RacialTrait) {
        self.race = race
    }
}

//    var theActors: [Actor] =
//    [Actor(name: "Marsel", actorClass: .barbarian, level: 1, mana: 1, maxHP: 1, currentHP: 1, armorClass: 1, experience: 1, race: .elf, isAlive: true, isActive: true),
//     Actor(name: "Scott", actorClass: .ranger, level: 2, mana: 5, maxHP: 50, currentHP: 50, armorClass: 2, experience: 2, race: .elf, isAlive: true, isActive: true),
//     Actor(name: "Ahmad", actorClass: .wizard, level: 3, mana: 9, maxHP: 100, currentHP: 100, armorClass: 3, experience: 3, race: .human, isAlive: true, isActive: true)
//    ]
