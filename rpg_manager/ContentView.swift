//import SwiftUI
//
//struct ContentView: View {
//    @State private var characters: [Actor] = []
//    
//    var body: some View {
//        HStack {
//            Button(action: {
//                // Add a Barbarian
//                let barbarian = Actor(name: "Barbarian \(self.characters.count + 1)", actorClass: .barbarian, level: 1, mana: 0, maxHP: 10, currentHP: 10, armorClass: 5, experience: 0, race: .human, isAlive: true, isActive: false)
//                self.characters.append(barbarian)
//            }) {
//                Text("Add Barbarian")
//            }
//            
//            Button(action: {
//                // Add a Wizard
//                let wizard = Actor(name: "Wizard \(self.characters.count + 1)", actorClass: .wizard, level: 1, mana: 20, maxHP: 8, currentHP: 8, armorClass: 3, experience: 0, race: .elf, isAlive: true, isActive: false)
//                self.characters.append(wizard)
//            }) {
//                Text("Add Wizard")
//            }
//            
//            Button(action: {
//                // Add a Ranger
//                let ranger = Actor(name: "Ranger \(self.characters.count + 1)", actorClass: .ranger, level: 1, mana: 10, maxHP: 12, currentHP: 12, armorClass: 7, experience: 0, race: .dwarf, isAlive: true, isActive: false)
//                self.characters.append(ranger)
//            }) {
//                Text("Add Ranger")
//            }
//            
//        }
//        .padding()
//    }
//    
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
