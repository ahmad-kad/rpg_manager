//
//  ActorView.swift
//  rpg_manager
//
//  Created by ahmad kaddoura on 4/19/24.
//

import Foundation
import SwiftUI

struct ActorFormView: View {
    @State private var name: String = ""
    @State private var selectedClass: CharacterClass = .barbarian // Default class
    @State private var level: Int = 1
    @State private var mana: Int = 0
    @State private var maxHP: Int = 10
    @State private var currentHP: Int = 10
    @State private var armorClass: Int = 5
    @State private var experience: Int = 0
    @State private var selectedRace: RacialTrait = .human // Default race
    
    private let characterClasses: [CharacterClass] = [.barbarian, .ranger, .wizard]
    private let racialTraits: [RacialTrait] = [.elf,.human,.dwarf]
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
            
            VStack{
                LabeledTextField(value: $name, label: "Name")
                HStack{
                Picker("Class", selection: $selectedClass) {
                    ForEach(characterClasses, id: \.self) { characterClass in
                        Text(characterClass.description.capitalized)
                            .tag(characterClass)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                    
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                    
                Picker("Race", selection: $selectedClass) {
                    ForEach(racialTraits, id: \.self) { racialTrait in
                        Text(racialTrait.description.capitalized)
                            .tag(racialTrait)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                }
            }.padding()
            
            VStack {
                HStack {
                    LabeledIntField(value: $level, label: "Level")
                    LabeledIntField(value: $mana, label: "Mana")
                    LabeledIntField(value: $maxHP, label: "Max HP")
                }
                HStack {
                    LabeledIntField(value: $currentHP, label: "Current HP")
                    LabeledIntField(value: $armorClass, label: "Armor Class")
                    LabeledIntField(value: $experience, label: "Experience")
                }
            }
            .padding()
            
            
            Button(action: {
                // Create actor based on entered properties
                let actor = createActor()
                // Handle saving actor or other actions
            }) {
                Text("Create Actor")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create Actor")
    }
    
    func createActor() -> Actor {
        // Create an actor based on the entered properties
        return Actor(name: name, actorClass: selectedClass, level: level, mana: mana, maxHP: maxHP, currentHP: currentHP, armorClass: armorClass, experience: experience, race: selectedRace, isAlive: true, isActive: false)
    }
}
struct LabeledIntField: View {
    @Binding var value: Int
    var label: String

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: Binding(get: {
                "\(value)"
            }, set: { newValue in
                if let number = Int(newValue) {
                    value = number
                }
            }), onEditingChanged: { _ in }, onCommit: {})
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .overlay(
                    Text(label)
                        .padding(.horizontal, 8)
                        .offset(x: 0, y: -30)
                        .scaleEffect(0.75, anchor: .leading)
                        .padding(.vertical, 2)
                )
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .font(.body)
                .foregroundColor(.black)
        }
    }
}
struct LabeledTextField: View {
    @Binding var value: String
    var label: String
    var formatter: NumberFormatter?

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $value, onEditingChanged: { _ in }, onCommit: {})
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .overlay(
                    Text(label)
                        .padding(.horizontal, 8)
                        .offset(x: 10, y: -10)
                        .foregroundColor(.gray)
                        .scaleEffect(0.75, anchor: .leading)
                        .padding(.vertical, 2)
                )
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .font(.body)
                .foregroundColor(.black)
            
            if let formatter = formatter {
                Rectangle()
                    .frame(width: 0, height: 0)
                    .hidden()
                    .background(EmptyView().onAppear {
                        formatter.numberStyle = .decimal
                    })
            }
        }
    }
}

#Preview {
    ActorFormView()
}
