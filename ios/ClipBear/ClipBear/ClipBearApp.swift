import SwiftUI

@main
struct ClipBearApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        // Initialize LocalizationManager
        _ = LocalizationManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    // Setup notification categories
                    NotificationService.shared.setupNotificationCategories()
                }
        }
    }
}

