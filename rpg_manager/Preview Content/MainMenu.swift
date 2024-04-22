//
//  MainMenu.swift
//  rpg_manager
//
//  Created by Marsel Abdullin on 4/30/24.
//

import SwiftUI

struct GlassmorphicButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(
                ZStack {
                    Color.black.opacity(0.25)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(.clear)
                        .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
                        .cornerRadius(10)
                }
            )
            .foregroundColor(.white)
            .font(.headline)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct MainMenu: View {
    
    @Binding var selectedTrait: RacialTrait
    @Binding var selectedClass: CharacterClass
    @Binding var heroName: String
    @Binding var newLevel: String
    @Binding var newMana: String
    @Binding var newMaxHP: String
    @Binding var newArmorClass: String
    @Binding var newExperience: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("fantasy1") // Replace with your actual background image name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)

                VStack {
                    // Custom title style
                    Text("RPG Manager")
                        .font(.custom("Pacifico", size: 36)) // Ensure the font is added to your project and Info.plist
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 60)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Ellipse())
                        .overlay(Ellipse().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 10)
                        .padding(.top, 40)
                    
                    Spacer()

                    VStack(spacing: 15) {
                        NavigationLink(destination: PageTwo(heroName: heroName, selectedTrait: selectedTrait, selectedClass: selectedClass, newLevel: newLevel, newMana: newMana, newMaxHP: newMaxHP, newArmorClass: newArmorClass, newExperience: newExperience).navigationBarBackButtonHidden(true)) {
                            Text("Create New Character")
                        }
                        .buttonStyle(GlassmorphicButtonStyle())

                        NavigationLink(destination: LoadChar(selectedTrait: $selectedTrait, selectedClass: $selectedClass, heroName: $heroName, newLevel: $newLevel, newMana: $newMana, newMaxHP: $newMaxHP, newArmorClass: $newArmorClass, newExperience: $newExperience).navigationBarBackButtonHidden(true)) {
                            Text("Load Character")
                        }
                        .buttonStyle(GlassmorphicButtonStyle())

                        NavigationLink(destination: CreditsView()) {
                            Text("Credits")
                        }
                        .buttonStyle(GlassmorphicButtonStyle())
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CreditsView: View {
    var body: some View {
        VStack {
            Text("Phuc Thinh Nguyen")
                .bold()
            Text("Marsel Abdullin")
                .bold()
            Text("Ahmad Kaddoura")
                .bold()
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(selectedTrait: .constant(.dwarf), selectedClass: .constant(.barbarian), heroName: .constant(""), newLevel: .constant(""), newMana: .constant(""), newMaxHP: .constant(""), newArmorClass: .constant(""), newExperience: .constant(""))
            .modelContainer(for: [Actor.self, PendingActor.self], inMemory: true)
    }
}
