import XCTest
import CoreData
@testable import ClipBear

class CoreDataMigrationTests: XCTestCase {
    
    var persistentContainer: NSPersistentContainer!
    
    override func setUpWithError() throws {
        // Create in-memory store for testing
        persistentContainer = NSPersistentContainer(name: "ClipBearDataModel")
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
    }
    
    override func tearDownWithError() throws {
        persistentContainer = nil
    }
    
    func testDataModelCreation() throws {
        // Test that the data model can be created
        XCTAssertNotNil(persistentContainer)
        XCTAssertNotNil(persistentContainer.managedObjectModel)
    }
    
    func testEntityCreation() throws {
        let context = persistentContainer.viewContext
        
        // Test ConsentRecord entity
        let consentRecord = NSEntityDescription.entity(forEntityName: "ConsentRecord", in: context)
        XCTAssertNotNil(consentRecord)
        
        // Test Suggestion entity
        let suggestion = NSEntityDescription.entity(forEntityName: "Suggestion", in: context)
        XCTAssertNotNil(suggestion)
        
        // Test SuggestionFeedback entity
        let suggestionFeedback = NSEntityDescription.entity(forEntityName: "SuggestionFeedback", in: context)
        XCTAssertNotNil(suggestionFeedback)
        
        // Test AppSettings entity
        let appSettings = NSEntityDescription.entity(forEntityName: "AppSettings", in: context)
        XCTAssertNotNil(appSettings)
    }
    
    func testDataInsertion() throws {
        let context = persistentContainer.viewContext
        
        // Insert ConsentRecord
        let consentRecord = NSEntityDescription.insertNewObject(forEntityName: "ConsentRecord", into: context)
        consentRecord.setValue(Date(), forKey: "timestamp")
        consentRecord.setValue("usage_stats,notifications", forKey: "scopes")
        consentRecord.setValue("en", forKey: "language")
        consentRecord.setValue("1.0", forKey: "version")
        
        // Insert Suggestion
        let suggestion = NSEntityDescription.insertNewObject(forEntityName: "Suggestion", into: context)
        suggestion.setValue(UUID(), forKey: "id")
        suggestion.setValue(Date(), forKey: "timestamp")
        suggestion.setValue("test_rule", forKey: "ruleId")
        suggestion.setValue("Test message", forKey: "message")
        suggestion.setValue("Test explanation", forKey: "explanation")
        suggestion.setValue("en", forKey: "language")
        suggestion.setValue(false, forKey: "isShown")
        suggestion.setValue(false, forKey: "isAccepted")
        suggestion.setValue("session1", forKey: "sessionId")
        
        // Insert SuggestionFeedback
        let feedback = NSEntityDescription.insertNewObject(forEntityName: "SuggestionFeedback", into: context)
        feedback.setValue(UUID(), forKey: "id")
        feedback.setValue(Date(), forKey: "timestamp")
        feedback.setValue("test_rule", forKey: "ruleId")
        feedback.setValue(true, forKey: "accepted")
        feedback.setValue("session1", forKey: "sessionId")
        
        // Insert AppSettings
        let appSettings = NSEntityDescription.insertNewObject(forEntityName: "AppSettings", into: context)
        appSettings.setValue("test_key", forKey: "key")
        appSettings.setValue("test_value", forKey: "value")
        appSettings.setValue(Date(), forKey: "timestamp")
        
        // Save context
        try context.save()
        
        // Verify data was saved
        let consentFetch = NSFetchRequest<NSManagedObject>(entityName: "ConsentRecord")
        let consents = try context.fetch(consentFetch)
        XCTAssertEqual(consents.count, 1)
        
        let suggestionFetch = NSFetchRequest<NSManagedObject>(entityName: "Suggestion")
        let suggestions = try context.fetch(suggestionFetch)
        XCTAssertEqual(suggestions.count, 1)
        
        let feedbackFetch = NSFetchRequest<NSManagedObject>(entityName: "SuggestionFeedback")
        let feedbacks = try context.fetch(feedbackFetch)
        XCTAssertEqual(feedbacks.count, 1)
        
        let settingsFetch = NSFetchRequest<NSManagedObject>(entityName: "AppSettings")
        let settings = try context.fetch(settingsFetch)
        XCTAssertEqual(settings.count, 1)
    }
    
    func testAppSettingsUniqueness() throws {
        let context = persistentContainer.viewContext
        
        // Create first setting
        let settings1 = NSEntityDescription.insertNewObject(forEntityName: "AppSettings", into: context)
        settings1.setValue("unique_key", forKey: "key")
        settings1.setValue("value1", forKey: "value")
        settings1.setValue(Date(), forKey: "timestamp")
        
        try context.save()
        
        // Try to create second setting with same key
        let settings2 = NSEntityDescription.insertNewObject(forEntityName: "AppSettings", into: context)
        settings2.setValue("unique_key", forKey: "key")
        settings2.setValue("value2", forKey: "value")
        settings2.setValue(Date(), forKey: "timestamp")
        
        // This should fail due to uniqueness constraint
        XCTAssertThrowsError(try context.save())
    }
    
    func testSuggestionExplanationField() throws {
        // Test that explanation field exists and works (critical for MVP)
        let context = persistentContainer.viewContext
        
        let suggestion = NSEntityDescription.insertNewObject(forEntityName: "Suggestion", into: context)
        suggestion.setValue(UUID(), forKey: "id")
        suggestion.setValue(Date(), forKey: "timestamp")
        suggestion.setValue("test_rule", forKey: "ruleId")
        suggestion.setValue("Test message", forKey: "message")
        suggestion.setValue("Test explanation - critical for explainability", forKey: "explanation")
        suggestion.setValue("en", forKey: "language")
        suggestion.setValue(false, forKey: "isShown")
        suggestion.setValue(false, forKey: "isAccepted")
        suggestion.setValue("test_session", forKey: "sessionId")
        
        try context.save()
        
        // Verify the explanation field exists and works
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Suggestion")
        let suggestions = try context.fetch(request)
        XCTAssertEqual(suggestions.count, 1)
        
        let fetchedSuggestion = suggestions.first!
        XCTAssertEqual(fetchedSuggestion.value(forKey: "explanation") as? String, "Test explanation - critical for explainability")
    }
    
    func testConsentRecordValidation() throws {
        let context = persistentContainer.viewContext
        
        // Test valid consent
        let validConsent = NSEntityDescription.insertNewObject(forEntityName: "ConsentRecord", into: context)
        validConsent.setValue(Date(), forKey: "timestamp")
        validConsent.setValue("usage_stats,notifications", forKey: "scopes")
        validConsent.setValue("en", forKey: "language")
        validConsent.setValue("1.0", forKey: "version")
        
        try context.save()
        
        // Test that consent validation works
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "ConsentRecord")
        let consents = try context.fetch(request)
        XCTAssertEqual(consents.count, 1)
        
        let consent = consents.first!
        XCTAssertNotNil(consent.value(forKey: "scopes"))
        XCTAssertNotNil(consent.value(forKey: "version"))
    }
    
    func testDataDeletion() throws {
        let context = persistentContainer.viewContext
        
        // Insert test data
        let suggestion = NSEntityDescription.insertNewObject(forEntityName: "Suggestion", into: context)
        suggestion.setValue(UUID(), forKey: "id")
        suggestion.setValue(Date(), forKey: "timestamp")
        suggestion.setValue("test_rule", forKey: "ruleId")
        suggestion.setValue("Test message", forKey: "message")
        suggestion.setValue("Test explanation", forKey: "explanation")
        suggestion.setValue("en", forKey: "language")
        suggestion.setValue(false, forKey: "isShown")
        suggestion.setValue(false, forKey: "isAccepted")
        suggestion.setValue("session1", forKey: "sessionId")
        
        try context.save()
        
        // Verify data exists
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Suggestion")
        let suggestions = try context.fetch(fetchRequest)
        XCTAssertEqual(suggestions.count, 1)
        
        // Delete data
        context.delete(suggestions[0])
        try context.save()
        
        // Verify data was deleted
        let suggestionsAfterDelete = try context.fetch(fetchRequest)
        XCTAssertEqual(suggestionsAfterDelete.count, 0)
    }
    
    func testDataExport() throws {
        let context = persistentContainer.viewContext
        
        // Insert test data
        let suggestion = NSEntityDescription.insertNewObject(forEntityName: "Suggestion", into: context)
        suggestion.setValue(UUID(), forKey: "id")
        suggestion.setValue(Date(), forKey: "timestamp")
        suggestion.setValue("test_rule", forKey: "ruleId")
        suggestion.setValue("Test message", forKey: "message")
        suggestion.setValue("Test explanation", forKey: "explanation")
        suggestion.setValue("en", forKey: "language")
        suggestion.setValue(false, forKey: "isShown")
        suggestion.setValue(false, forKey: "isAccepted")
        suggestion.setValue("session1", forKey: "sessionId")
        
        try context.save()
        
        // Test data export (simplified)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Suggestion")
        let suggestions = try context.fetch(fetchRequest)
        
        let exportData = suggestions.map { suggestion in
            [
                "id": (suggestion.value(forKey: "id") as? UUID)?.uuidString ?? "",
                "timestamp": suggestion.value(forKey: "timestamp") as? Date ?? Date(),
                "ruleId": suggestion.value(forKey: "ruleId") as? String ?? "",
                "message": suggestion.value(forKey: "message") as? String ?? "",
                "explanation": suggestion.value(forKey: "explanation") as? String ?? "",
                "language": suggestion.value(forKey: "language") as? String ?? "",
                "isShown": suggestion.value(forKey: "isShown") as? Bool ?? false,
                "isAccepted": suggestion.value(forKey: "isAccepted") as? Bool ?? false,
                "sessionId": suggestion.value(forKey: "sessionId") as? String ?? ""
            ]
        }
        
        XCTAssertEqual(exportData.count, 1)
        XCTAssertEqual(exportData[0]["ruleId"] as? String, "test_rule")
        XCTAssertEqual(exportData[0]["explanation"] as? String, "Test explanation")
    }
}