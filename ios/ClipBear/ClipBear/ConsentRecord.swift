import Foundation
import CoreData

@objc(ConsentRecord)
public class ConsentRecord: NSManagedObject {
    
}

extension ConsentRecord {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsentRecord> {
        return NSFetchRequest<ConsentRecord>(entityName: "ConsentRecord")
    }
    
    @NSManaged public var timestamp: Date
    @NSManaged public var scopes: String // JSON string of consented scopes
    @NSManaged public var language: String
    @NSManaged public var version: String
}

extension ConsentRecord {
    
    static func create(
        scopes: [String],
        language: String,
        version: String = "1.0",
        in context: NSManagedObjectContext
    ) -> ConsentRecord? {
        // Ensure the context has a persistent store coordinator
        guard context.persistentStoreCoordinator != nil else {
            print("Warning: Context does not have a persistent store coordinator, Core Data not ready yet")
            return nil
        }
        
        // Check if the entity description exists
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "ConsentRecord", in: context) else {
            print("Warning: ConsentRecord entity not found in the model")
            return nil
        }
        
        let consent = ConsentRecord(entity: entityDescription, insertInto: context)
        consent.timestamp = Date()
        consent.scopes = try! JSONEncoder().encode(scopes).base64EncodedString()
        consent.language = language
        consent.version = version
        return consent
    }
    
    func getScopes() -> [String] {
        guard let data = Data(base64Encoded: scopes),
              let scopesArray = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return scopesArray
    }
    
    /// Check if consent is still valid (no expiration, only version matters)
    var isConsented: Bool {
        return !scopes.isEmpty
    }
    
    /// Check if user needs to re-consent based on policy version
    /// - Parameter currentPolicyVersion: The current policy version to check against
    /// - Returns: True if user needs to re-consent due to policy change
    func needsReconsent(currentPolicyVersion: String) -> Bool {
        // Compare versions - user needs to reconsent if stored version is older
        return version != currentPolicyVersion
    }
    
    /// Convenience method to check if consent is valid for current policy
    /// - Parameter currentPolicyVersion: The current policy version
    /// - Returns: True if consent is valid and doesn't need renewal
    func isValidForPolicy(_ currentPolicyVersion: String) -> Bool {
        return isConsented && !needsReconsent(currentPolicyVersion: currentPolicyVersion)
    }
}
