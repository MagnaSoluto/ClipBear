import Foundation
import CoreData

@objc(AppSettings)
public class AppSettings: NSManagedObject {
    
}

extension AppSettings {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppSettings> {
        return NSFetchRequest<AppSettings>(entityName: "AppSettings")
    }
    
    @NSManaged public var key: String
    @NSManaged public var value: String
    @NSManaged public var timestamp: Date
}

extension AppSettings {
    
    static func create(
        key: String,
        value: String,
        in context: NSManagedObjectContext
    ) -> AppSettings {
        let settings = AppSettings(context: context)
        settings.key = key
        settings.value = value
        settings.timestamp = Date()
        return settings
    }
    
    static func getValue(for key: String, in context: NSManagedObjectContext) -> String? {
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        request.predicate = NSPredicate(format: "key == %@", key)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            return results.first?.value
        } catch {
            return nil
        }
    }
    
    static func setValue(_ value: String, for key: String, in context: NSManagedObjectContext) {
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        request.predicate = NSPredicate(format: "key == %@", key)
        request.fetchLimit = 1
        
        do {
            let results = try context.fetch(request)
            if let existing = results.first {
                existing.value = value
                existing.timestamp = Date()
            } else {
                _ = AppSettings.create(key: key, value: value, in: context)
            }
            try context.save()
        } catch {
            print("Error saving setting: \(error)")
        }
    }
}

// Settings Keys
extension AppSettings {
    static let languageKey = "language"
    static let intensityKey = "intensity"
    static let snoozeUntilKey = "snooze_until"
    static let overlayEnabledKey = "overlay_enabled"
    static let diagnosticsEnabledKey = "diagnostics_enabled"
    static let lastActiveSessionKey = "last_active_session"
}
