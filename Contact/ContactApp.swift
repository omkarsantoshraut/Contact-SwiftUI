import SwiftUI
import SwiftData

@main
struct ContactApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Contact.self,
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
            ContactHomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
