import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Create sample data for previews
        if let sampleConsent = ConsentRecord.create(
            scopes: ["usage_stats", "notifications", "widgets"],
            language: "en",
            in: viewContext
        ) {
            // Sample consent created successfully
        }
        
        if let sampleSuggestion = Suggestion.create(
            ruleId: "screen_restlessness",
            message: "Take a short break?",
            explanation: "Because you turned your screen on/off 6 times in 10 minutes",
            language: "en",
            sessionId: "preview_session",
            in: viewContext
        ) {
            // Sample suggestion created successfully
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ClipBearDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Enable encryption for Core Data
        let description = container.persistentStoreDescriptions.first
        description?.setOption(FileProtectionType.complete as NSString, forKey: NSPersistentStoreFileProtectionKey)
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
