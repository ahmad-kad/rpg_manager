//
//  EditChar.swift
//  rpg_manager
//
//  Created by Phuc Thinh Nguyen on 5/8/24.
//

import SwiftUI

struct EditChar: View {
    
    @State private var selectedTrait: RacialTrait
    @State private var selectedClass: CharacterClass

    @State var heroName: String
    
    @State private var newLevel: String
    @State private var newMana: String
    @State private var newMaxHP: String
    @State private var newArmorClass: String
    @State private var newExperience: String
    
    @State var editingActor: Actor
    
    init(editingActor: Actor) {
        self.editingActor = editingActor
        self._selectedClass = State(initialValue: editingActor.getActorClass())
        self._selectedTrait = State(initialValue: editingActor.getRace())
        self._heroName = State(initialValue: "\(editingActor.getName())")
        self._newLevel = State(initialValue: "\(editingActor.getLevel())")
        self._newMana = State(initialValue: "\(editingActor.getMana())")
        self._newMaxHP = State(initialValue: "\(editingActor.getMaxHP())")
        self._newArmorClass = State(initialValue: "\(editingActor.getArmorClass())")
        self._newExperience = State(initialValue: "\(editingActor.getExperience())")
    }
    
    var body: some View {
            NavigationStack {
                VStack {
                    ZStack{
                        Form {
                            Section(header: Text("           Choose Race and Class ").font(.headline))
                            {
                                Picker("Choose a Race Trait", selection: $selectedTrait) {
                                    ForEach(RacialTrait.allCases, id: \.self) { racialTrait in
                                        Text(racialTrait.description)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: selectedTrait) {_, _ in
                                    editingActor.setRace(race: selectedTrait)
                                }
                                
                                Picker("Choose a Class", selection: $selectedClass) {
                                    ForEach(CharacterClass.allCases, id: \.self) { characterClass in
                                        Text(characterClass.description)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: selectedClass) {_, _ in
                                    editingActor.setActorClass(actorClass: selectedClass)
                                }
                            }
                            ChosenHeroViewOne(editingActor: $editingActor, selectedTrait: $selectedTrait, selectedClass: $selectedClass, heroName: $heroName, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience)
                        }
                        .navigationTitle("Edit Character")
                    }
                }
            }
        }
    }


struct ChosenHeroViewOne: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var editingActor: Actor
    
    @Binding var selectedTrait: RacialTrait
    @Binding var selectedClass: CharacterClass
    @Binding var heroName: String
    @Binding var newLevel: String
    @Binding var newMana: String
    @Binding var newMaxHP: String
    @Binding var newArmorClass: String
    @Binding var newExperience: String
    
    var body: some View {
        VStack {
            HeroImageViewOne(heroName: "\(editingActor.getRace().description.lowercased())_\(editingActor.getActorClass().description.lowercased())", editingActor: $editingActor, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience)
                .padding()
                .imageScale(.large)
            Text("Enter Character Name Below")
                .bold()
            TextField("Character Name", text: $heroName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 170, height: 40)
                .onChange(of: $heroName.wrappedValue) {
                    editingActor.setName(name: heroName)
                }
            Spacer()
            HStack {
                Button("Delete") {
                    modelContext.delete(editingActor)
                    dismiss()
                }
                .buttonStyle(GlassmorphicButtonStyle())
                
                Button("Save") {
                    if !(heroName != "" && newLevel != "" && newMana != "" && newMaxHP != "" && newArmorClass != "" && newExperience != "") {
                        newPendingActor()
                    }
                    dismiss()
                }
                .buttonStyle(GlassmorphicButtonStyle())
            }
            Spacer()
        }
    }
    
    func newPendingActor() {
        let newPendingActor = PendingActor(pendingName: heroName, pendingActorClass: selectedClass, pendingLevel: newLevel, pendingMana: newMana, pendingMaxHP: newMaxHP, pendingCurrentHP: newMaxHP, pendingArmorClass: newArmorClass, pendingExperience: newExperience, pendingRace: selectedTrait, pendingIsAlive: false, pendingIsActive: false)
        modelContext.insert(newPendingActor)
        modelContext.delete(editingActor)
    }
}

struct HeroImageViewOne: View {
    
    var heroName: String
    
    @Binding var editingActor: Actor
    
    @Binding var newLevel: String
    @Binding var newMana: String
    @Binding var newMaxHP: String
    @Binding var newArmorClass: String
    @Binding var newExperience: String


    var body: some View {
        HStack {
            Image(heroName)
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 170)
                .shadow(color: .white , radius: 30)
            
            VStack(alignment: .leading) {
                Text("Level: ")
                    .font(.callout)
                    .overlay(
                        TextField("Enter", text: $newLevel)
                            .offset(x: 75)
                    )
                    .onChange(of: $newLevel.wrappedValue) {
                        if Int($newLevel.wrappedValue) == nil {
                            $newLevel.wrappedValue = String($newLevel.wrappedValue.prefix($newLevel.wrappedValue.count >= 1 ? $newLevel.wrappedValue.count - 1 : 0))
                        }
                        else {
                            editingActor.setLevel(level: Int(newLevel)!)
                        }
                    }
                Text("Mana: ")
                    .font(.callout)
                    .overlay(
                        TextField("Enter", text: $newMana)
                            .offset(x: 75)
                    )
                    .onChange(of: $newMana.wrappedValue) {
                        if Int($newMana.wrappedValue) == nil {
                            $newMana.wrappedValue = String($newMana.wrappedValue.prefix($newMana.wrappedValue.count >= 1 ? $newMana.wrappedValue.count - 1 : 0))
                        }
                        else {
                            editingActor.setMana(mana: Int(newMana)!)
                        }
                    }
                Text("HP:    ")
                    .font(.callout)
                    .overlay(
                        TextField("Enter", text: $newMaxHP)
                            .offset(x: 75)
                    )
                    .onChange(of: $newMaxHP.wrappedValue) {
                        if Int($newMaxHP.wrappedValue) == nil {
                            $newMaxHP.wrappedValue = String($newMaxHP.wrappedValue.prefix($newMaxHP.wrappedValue.count >= 1 ? $newMaxHP.wrappedValue.count - 1 : 0))
                        }
                        else {
                            editingActor.setMaxHP(maxHP: Int(newMaxHP)!)
                        }
                    }
                Text("Armor: ")
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                    .overlay(
                        TextField("Enter", text: $newArmorClass)
                            .offset(x: 75)
                    )
                    .onChange(of: $newArmorClass.wrappedValue) {
                        if Int($newArmorClass.wrappedValue) == nil {
                            $newArmorClass.wrappedValue = String($newArmorClass.wrappedValue.prefix($newArmorClass.wrappedValue.count >= 1 ? $newArmorClass.wrappedValue.count - 1 : 0))
                        }
                        else {
                            editingActor.setArmorClass(armorClass: Int(newArmorClass)!)
                        }
                    }
                Text("XP:     ")
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                    .overlay(
                        TextField("Enter", text: $newExperience)
                            .offset(x: 75)
                    )
                    .onChange(of: $newExperience.wrappedValue) {
                        if Int($newExperience.wrappedValue) == nil {
                            $newExperience.wrappedValue = String($newExperience.wrappedValue.prefix($newExperience.wrappedValue.count >= 1 ? $newExperience.wrappedValue.count - 1 : 0))
                        }
                        else {
                            editingActor.setExperience(experience: Int(newExperience)!)
                        }
                    }
            }
            .padding(.horizontal)
        }
    }
}

// Provide SwiftUI previews
struct EditChar_Previews: PreviewProvider {
    static var previews: some View {
        EditChar(editingActor: Actor(name: "", actorClass: .barbarian, level: 0, mana: 0, maxHP: 0, currentHP: 0, armorClass: 0, experience: 0, race: .dwarf, isAlive: true, isActive: true))
    }
}
