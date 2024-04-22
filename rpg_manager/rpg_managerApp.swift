import SwiftUI
import SwiftData

@main
struct rpg_managerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Actor.self, PendingActor.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainMenu(selectedTrait: .constant(.dwarf), selectedClass: .constant(.wizard), heroName: .constant(""), newLevel: .constant(""), newMana: .constant(""), newMaxHP: .constant(""), newArmorClass: .constant(""), newExperience: .constant(""))
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}
