//
//  LoadChar.swift
//  rpg_manager
//
//  Created by Marsel Abdullin on 4/30/24.
//

import SwiftUI
import SwiftData

struct LoadChar: View {
    
    @Binding var selectedTrait: RacialTrait
    @Binding var selectedClass: CharacterClass

    @Binding var heroName: String
    
    @Binding var newLevel: String
    @Binding var newMana: String
    @Binding var newMaxHP: String
    @Binding var newArmorClass: String
    @Binding var newExperience: String
    
    @State var isAtMainMenu: Bool = false
    @State var isCreatedNewChar: Bool = false
    
    @Query private var actors: [Actor]
    @Query private var pendingActors: [PendingActor]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("forest") // Replace with your actual background image name
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Color.black.opacity(0.6).ignoresSafeArea()
            
            GeometryReader {geometry in
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("< Home")
                            .bold()
                            .foregroundStyle(.white)
                            .offset(x: 20)
                    }
                    Spacer()
                    Button(action: {
                        isCreatedNewChar.toggle()
                    }) {
                        Text("New +")
                            .bold()
                            .foregroundStyle(.white)
                            .offset(x: -20)
                    }
                    .navigationDestination(isPresented: $isCreatedNewChar) {
                        PageTwo(heroName: heroName, selectedTrait: selectedTrait, selectedClass: selectedClass, newLevel: newLevel, newMana: newMana, newMaxHP: newMaxHP, newArmorClass: newArmorClass, newExperience: newExperience).navigationBarBackButtonHidden(true)
                    }
                }
                
                HStack {
                    Text("Completed")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.system(size: 36))
                        .offset(x: 20)
                    Spacer()
                }
                .offset(y: geometry.size.width * 0.15)
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.275)
                        .foregroundStyle(.cyan.tertiary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black.quaternary, lineWidth: 6)
                        )
                        .offset(y: geometry.size.width * 0.3)
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(actors) {actor in
                                NavigationLink(destination: EditChar(editingActor: actor)) {
                                    let hero = "\(actor.getRace().description.lowercased())_\(actor.getActorClass().description.lowercased())"
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 120, height: 200)
                                            .foregroundStyle(.black.secondary)
                                        VStack {
                                            Text(actor.getName())
                                                .foregroundStyle(.white)
                                                .bold()
                                                .offset(y: 15)
                                            Image(hero)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 170)
                                                .shadow(radius: 10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(.horizontal, 37.5)
                    .offset(y: geometry.size.width * 0.3)
                }
                
                //Pending
                HStack {
                    Text("Pending")
                        .foregroundStyle(.white)
                        .bold()
                        .font(.system(size: 36))
                        .offset(x: 20)
                    Spacer()
                }
                .offset(y: geometry.size.width * 1.05)
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.275)
                        .foregroundStyle(.brown.tertiary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black.quaternary, lineWidth: 6)
                        )
                        .offset(y: geometry.size.width * 1.25)
                    ScrollView (.horizontal) {
                        HStack {
                            ForEach(pendingActors) {pendingActor in
                                NavigationLink(destination: EditCharForPending(pendingEditingActor: pendingActor)) {
                                    let hero = "\(pendingActor.getPendingRace().description.lowercased())_\(pendingActor.getPendingActorClass().description.lowercased())"
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 120, height: 200)
                                            .foregroundStyle(.black.secondary)
                                        VStack {
                                            Text(pendingActor.getPendingName())
                                                .foregroundStyle(.white)
                                                .bold()
                                                .offset(y: 15)
                                            Image(hero)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 170)
                                                .shadow(radius: 10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(.horizontal, 37.5)
                    .offset(y: geometry.size.width * 1.25)
                }
            }
        }
    }
}

#Preview {
    LoadChar(selectedTrait: .constant(.dwarf), selectedClass: .constant(.barbarian), heroName: .constant(""), newLevel: .constant(""), newMana: .constant(""), newMaxHP: .constant(""), newArmorClass: .constant(""), newExperience: .constant(""))
}
