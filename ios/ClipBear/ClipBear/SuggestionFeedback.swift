import Foundation
import CoreData

@objc(SuggestionFeedback)
public class SuggestionFeedback: NSManagedObject {
    
}

extension SuggestionFeedback {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuggestionFeedback> {
        return NSFetchRequest<SuggestionFeedback>(entityName: "SuggestionFeedback")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var ruleId: String
    @NSManaged public var accepted: Bool
    @NSManaged public var sessionId: String
}

extension SuggestionFeedback {
    
    static func create(
        ruleId: String,
        accepted: Bool,
        sessionId: String,
        in context: NSManagedObjectContext
    ) -> SuggestionFeedback {
        let feedback = SuggestionFeedback(context: context)
        feedback.id = UUID()
        feedback.timestamp = Date()
        feedback.ruleId = ruleId
        feedback.accepted = accepted
        feedback.sessionId = sessionId
        return feedback
    }
}
