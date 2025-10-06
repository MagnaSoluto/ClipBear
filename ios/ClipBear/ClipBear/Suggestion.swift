import Foundation
import CoreData

@objc(Suggestion)
public class Suggestion: NSManagedObject {
    
}

extension Suggestion {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Suggestion> {
        return NSFetchRequest<Suggestion>(entityName: "Suggestion")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var ruleId: String
    @NSManaged public var message: String
    @NSManaged public var explanation: String // "Why" field - CRITICAL for MVP
    @NSManaged public var language: String
    @NSManaged public var isShown: Bool
    @NSManaged public var isAccepted: Bool
    @NSManaged public var feedbackTimestamp: Date?
    @NSManaged public var sessionId: String
}

extension Suggestion {
    
    static func create(
        ruleId: String,
        message: String,
        explanation: String,
        language: String,
        sessionId: String,
        in context: NSManagedObjectContext
    ) -> Suggestion? {
        // Ensure the context has a persistent store coordinator
        guard context.persistentStoreCoordinator != nil else {
            print("Warning: Context does not have a persistent store coordinator, Core Data not ready yet")
            return nil
        }
        
        // Check if the entity description exists
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Suggestion", in: context) else {
            print("Warning: Suggestion entity not found in the model")
            return nil
        }
        
        let suggestion = Suggestion(entity: entityDescription, insertInto: context)
        suggestion.id = UUID()
        suggestion.timestamp = Date()
        suggestion.ruleId = ruleId
        suggestion.message = message
        suggestion.explanation = explanation
        suggestion.language = language
        suggestion.sessionId = sessionId
        suggestion.isShown = false
        suggestion.isAccepted = false
        return suggestion
    }
    
    func markAsShown() {
        isShown = true
    }
    
    func markAsAccepted() {
        isAccepted = true
        feedbackTimestamp = Date()
    }
    
    func markAsRejected() {
        isAccepted = false
        feedbackTimestamp = Date()
    }
    
    var feedbackStatus: String {
        if isAccepted {
            return "accepted"
        } else if feedbackTimestamp != nil {
            return "rejected"
        } else {
            return "pending"
        }
    }
}
