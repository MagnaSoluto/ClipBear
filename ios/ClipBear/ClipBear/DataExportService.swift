import Foundation
import CoreData
import SwiftUI

class DataExportService: ObservableObject {
    static let shared = DataExportService()
    
    @Published var exportedURL: URL?
    
    private init() {}
    
    func exportAllData() -> URL? {
        let context = PersistenceController.shared.container.viewContext
        
        var exportData: [String: Any] = [:]
        
        // Export settings
        let settingsRequest: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        if let settings = try? context.fetch(settingsRequest) {
            exportData["settings"] = settings.map { [
                "key": $0.key,
                "value": $0.value,
                "timestamp": $0.timestamp.timeIntervalSince1970
            ]}
        }
        
        // Export consent records
        let consentRequest: NSFetchRequest<ConsentRecord> = ConsentRecord.fetchRequest()
        if let consents = try? context.fetch(consentRequest) {
            exportData["consent_records"] = consents.map { [
                "timestamp": $0.timestamp.timeIntervalSince1970,
                "scopes": $0.getScopes(),
                "language": $0.language,
                "version": $0.version
            ]}
        }
        
        // Export suggestions
        let suggestionRequest: NSFetchRequest<Suggestion> = Suggestion.fetchRequest()
        if let suggestions = try? context.fetch(suggestionRequest) {
            exportData["suggestions"] = suggestions.map { [
                "id": $0.id.uuidString,
                "timestamp": $0.timestamp.timeIntervalSince1970,
                "ruleId": $0.ruleId,
                "message": $0.message,
                "explanation": $0.explanation,
                "language": $0.language,
                "isShown": $0.isShown,
                "isAccepted": $0.isAccepted,
                "feedbackTimestamp": $0.feedbackTimestamp?.timeIntervalSince1970 ?? 0,
                "sessionId": $0.sessionId
            ]}
        }
        
        // Export feedback
        let feedbackRequest: NSFetchRequest<SuggestionFeedback> = SuggestionFeedback.fetchRequest()
        if let feedbacks = try? context.fetch(feedbackRequest) {
            exportData["feedback"] = feedbacks.map { [
                "id": $0.id.uuidString,
                "timestamp": $0.timestamp.timeIntervalSince1970,
                "ruleId": $0.ruleId,
                "accepted": $0.accepted,
                "sessionId": $0.sessionId
            ]}
        }
        
        // Add metadata
        exportData["export_metadata"] = [
            "exported_at": Date().timeIntervalSince1970,
            "app_version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0",
            "platform": "iOS"
        ]
        
        // Save to temporary file
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: exportData, options: .prettyPrinted)
            let tempURL = FileManager.default.temporaryDirectory
                .appendingPathComponent("clipbear_export_\(Date().timeIntervalSince1970).json")
            
            try jsonData.write(to: tempURL)
            
            // Store URL in state for reuse
            DispatchQueue.main.async {
                self.exportedURL = tempURL
            }
            
            return tempURL
        } catch {
            print("Error exporting data: \(error)")
            return nil
        }
    }
    
    func deleteAllData() {
        let context = PersistenceController.shared.container.viewContext
        
        // Delete all entities using NSBatchDeleteRequest
        let entities = ["AppSettings", "ConsentRecord", "Suggestion", "SuggestionFeedback"]
        
        for entityName in entities {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeObjectIDs
            
            do {
                let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
                let objectIDArray = result?.result as? [NSManagedObjectID]
                let changes = [NSDeletedObjectsKey: objectIDArray ?? []]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            } catch {
                print("Error deleting \(entityName): \(error)")
            }
        }
        
        // Save context
        do {
            try context.save()
        } catch {
            print("Error saving after deletion: \(error)")
        }
        
        // Clear widget
        WidgetService.shared.clearWidget()
    }
}
