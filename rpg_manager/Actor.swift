//
//  Actor.swift
//  rpg_manager
//
//  Created by Scottyyyyyy on 4/1/24.
//

import Foundation

// ---
struct Item {
    // Define item properties here
}

// Define List struct
struct List {
    // Define list properties here
}

class Actor{
    
    private var name: String = ""
    
    private var actorClass: CharacterClass
    
    private var level: Int = 0
    private var mana: Int = 0
    private var maxHP: Int = 0
    private var currentHP: Int = 0
    private var armorClass: Int = 0
    private var experience: Int = 0
    
    //private var inventory: List
    
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
        //self.inventory = inventory
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

    /*
    func getInventory() -> Int {
        return inventory
    }
    func setInventory(inventory: Int) {
        self.inventory = inventory
    }
     */

    func getRace() -> RacialTrait {
        return race
    }
    func setRace(race: RacialTrait) {
        self.race = race
    }
    
}
