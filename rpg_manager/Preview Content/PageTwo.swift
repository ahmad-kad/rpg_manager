//
//  PageTwo.swift
//  rpg_manager
//
//  Created by Marsel Abdullin on 4/30/24.
//

import SwiftUI

struct PageTwo: View {
    
    @State var heroName: String = ""
    
    @State var selectedTrait: RacialTrait = .dwarf
    @State var selectedClass: CharacterClass = .barbarian
    
    @State var newLevel: String
    @State var newMana: String
    @State var newMaxHP: String
    @State var newArmorClass: String
    @State var newExperience: String
    
    init(heroName: String, selectedTrait: RacialTrait, selectedClass: CharacterClass, newLevel: String, newMana: String, newMaxHP: String, newArmorClass: String, newExperience: String) {
        self.heroName = ""
        self.selectedTrait = .dwarf
        self.selectedClass = .barbarian
        self.newLevel = ""
        self.newMana = ""
        self.newMaxHP = ""
        self.newArmorClass = ""
        self.newExperience = ""
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
                                
                                Picker("Choose a Class", selection: $selectedClass) {
                                    ForEach(CharacterClass.allCases, id: \.self) { characterClass in
                                        Text(characterClass.description)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            ChosenHeroView(selectedTrait: $selectedTrait, selectedClass: $selectedClass, heroName: $heroName, isCreated: false, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience)
                        }
                        .navigationTitle("Customize Character")
                    }
                }
                    
            }
        
        }
    }

struct ChosenHeroView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedTrait: RacialTrait
    @Binding var selectedClass: CharacterClass
    @Binding var heroName: String
    
    @State var isCreated: Bool = false
    
    @Binding var newLevel: String
    @Binding var newMana: String
    @Binding var newMaxHP: String
    @Binding var newArmorClass: String
    @Binding var newExperience: String

    var body: some View {
        VStack {
            HeroImageView(heroName: "\(selectedTrait.description.lowercased())_\(selectedClass.description.lowercased())", newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience)
                .padding()
                .imageScale(.large)
            Text("Enter Character Name Below")
                .bold()
            TextField("Character Name", text: $heroName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 170, height: 40)
            Spacer()
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(GlassmorphicButtonStyle())
                
                Button("Create") {
                    updateActor()
                    isCreated.toggle()
                }
                .buttonStyle(GlassmorphicButtonStyle())
                .navigationDestination(isPresented: $isCreated) {
                    LoadChar(selectedTrait: $selectedTrait, selectedClass: $selectedClass, heroName: $heroName, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience).navigationBarBackButtonHidden(true)
                }
            }
            Spacer()
        }
    }
    
    func updateActor() {
        if (heroName != "" && newLevel != "" && newMana != "" && newMaxHP != "" && newArmorClass != "" && newExperience != "") {
            let newActor = Actor(name: heroName, actorClass: selectedClass, level: Int(newLevel)!, mana: Int(newMana)!, maxHP: Int(newMaxHP)!, currentHP: Int(newMaxHP)!, armorClass: Int(newArmorClass)!, experience: Int(newExperience)!, race: selectedTrait, isAlive: true, isActive: true)
            modelContext.insert(newActor)
        }
        else {
            let newPendingActor = PendingActor(pendingName: heroName, pendingActorClass: selectedClass, pendingLevel: newLevel, pendingMana: newMana, pendingMaxHP: newMaxHP, pendingCurrentHP: newMaxHP, pendingArmorClass: newArmorClass, pendingExperience: newExperience, pendingRace: selectedTrait, pendingIsAlive: false, pendingIsActive: false)
            modelContext.insert(newPendingActor)
        }
    }
}

struct HeroImageView: View {
    var heroName: String

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
                    }
            }
            .padding(.horizontal)
        }
    }
}

// Provide SwiftUI previews
struct PageTwo_Previews: PreviewProvider {
    static var previews: some View {
        PageTwo(heroName: "Marsel", selectedTrait: .dwarf, selectedClass: .barbarian, newLevel: "", newMana: "", newMaxHP: "", newArmorClass: "", newExperience: "")
    }
}
