//
//  EditCharForPending.swift
//  rpg_manager
//
//  Created by Phuc Thinh Nguyen on 5/8/24.
//

import SwiftUI

struct EditCharForPending: View {
    
    @State private var selectedTrait: RacialTrait
    @State private var selectedClass: CharacterClass

    @State var heroName: String
    
    @State private var newLevel: String
    @State private var newMana: String
    @State private var newMaxHP: String
    @State private var newArmorClass: String
    @State private var newExperience: String
    
    @State var pendingEditingActor: PendingActor
    
    init(pendingEditingActor: PendingActor) {
        self.pendingEditingActor = pendingEditingActor
        self._selectedClass = State(initialValue: pendingEditingActor.getPendingActorClass())
        self._selectedTrait = State(initialValue: pendingEditingActor.getPendingRace())
        self._heroName = State(initialValue: "\(pendingEditingActor.getPendingName())")
        self._newLevel = State(initialValue: "\(pendingEditingActor.getPendingLevel())")
        self._newMana = State(initialValue: "\(pendingEditingActor.getPendingMana())")
        self._newMaxHP = State(initialValue: "\(pendingEditingActor.getPendingMaxHP())")
        self._newArmorClass = State(initialValue: "\(pendingEditingActor.getPendingArmorClass())")
        self._newExperience = State(initialValue: "\(pendingEditingActor.getPendingExperience())")
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
                                    pendingEditingActor.setPendingRace(pendingRace: selectedTrait)
                                }
                                
                                Picker("Choose a Class", selection: $selectedClass) {
                                    ForEach(CharacterClass.allCases, id: \.self) { characterClass in
                                        Text(characterClass.description)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .onChange(of: selectedClass) {_, _ in
                                    pendingEditingActor.setPendingActorClass(pendingActorClass: selectedClass)
                                }
                            }
                            ChosenHeroViewTwo(pendingEditingActor: $pendingEditingActor, selectedTrait: $selectedTrait, selectedClass: $selectedClass, heroName: $heroName, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience)
                        }
                        .navigationTitle("Edit Character")
                    }
                }
            }
        }
    }


struct ChosenHeroViewTwo: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var pendingEditingActor: PendingActor
    
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
            HeroImageViewTwo(heroName: "\(pendingEditingActor.getPendingRace().description.lowercased())_\(pendingEditingActor.getPendingActorClass().description.lowercased())", pendingEditingActor: $pendingEditingActor, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience)
                .padding()
                .imageScale(.large)
            Text("Enter Character Name Below")
                .bold()
            TextField("Character Name", text: $heroName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 170, height: 40)
                .onChange(of: $heroName.wrappedValue) {
                    pendingEditingActor.setPendingName(pendingName: heroName)
                }
            Spacer()
            HStack {
                Button("Delete") {
                    modelContext.delete(pendingEditingActor)
                    dismiss()
                }
                .buttonStyle(GlassmorphicButtonStyle())
                
                Button("Save") {
                    if (heroName != "" && newLevel != "" && newMana != "" && newMaxHP != "" && newArmorClass != "" && newExperience != "") {
                        completedActor()
                    }
                    dismiss()
                }
                .buttonStyle(GlassmorphicButtonStyle())
            }
            Spacer()
        }
    }
    
    func completedActor() {
        let completedActor = Actor(name: heroName, actorClass: selectedClass, level: Int(newLevel)!, mana: Int(newMana)!, maxHP: Int(newMaxHP)!, currentHP: Int(newMaxHP)!, armorClass: Int(newArmorClass)!, experience: Int(newExperience)!, race: selectedTrait, isAlive: true, isActive: true)
        modelContext.insert(completedActor)
        modelContext.delete(pendingEditingActor)
    }
}





struct HeroImageViewTwo: View {
    
    var heroName: String
    
    @Binding var pendingEditingActor: PendingActor
    
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
                            pendingEditingActor.setPendingLevel(pendingLevel: newLevel)
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
                            pendingEditingActor.setPendingMana(pendingMana: newMana)
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
                            pendingEditingActor.setPendingMaxHP(pendingMaxHP: newMaxHP)
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
                            pendingEditingActor.setPendingArmorClass(pendingArmorClass: newArmorClass)
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
                            pendingEditingActor.setPendingExperience(pendingExperience: newExperience)
                        }
                    }
            }
            .padding(.horizontal)
        }
    }
}

// Provide SwiftUI previews
struct EditCharForPending_Previews: PreviewProvider {
    static var previews: some View {
        EditCharForPending(pendingEditingActor: PendingActor(pendingName: "", pendingActorClass: .barbarian, pendingLevel: "", pendingMana: "", pendingMaxHP: "", pendingCurrentHP: "", pendingArmorClass: "", pendingExperience: "", pendingRace: .dwarf, pendingIsAlive: true, pendingIsActive: true))
    }
}
