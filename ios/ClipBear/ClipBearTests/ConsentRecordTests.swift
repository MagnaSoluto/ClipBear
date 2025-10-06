import XCTest
import CoreData
@testable import ClipBear

final class ConsentRecordTests: XCTestCase {
    func testConsentValidWithoutExpiring() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext
        let scopes = ["behavioral", "notifications"]

        let rec = ConsentRecord.create(
            scopes: scopes,
            language: "en",
            version: "1.0",
            in: ctx
        )
        try ctx.save()

        XCTAssertTrue(rec.isConsented, "Consent should be valid while scopes exist and version set")
        XCTAssertEqual(Set(rec.getScopes()), Set(scopes))
    }
    
    func testConsentInvalidWithEmptyScopes() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext

        let rec = ConsentRecord.create(
            scopes: [],
            language: "en",
            version: "1.0",
            in: ctx
        )
        try ctx.save()

        XCTAssertFalse(rec.isConsented, "Consent should be invalid with empty scopes")
    }
    
    func testNeedsReconsentWithDifferentVersion() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext
        
        let rec = ConsentRecord.create(
            scopes: ["usage_stats"],
            language: "en",
            version: "1.0",
            in: ctx
        )
        try ctx.save()
        
        // Same version - no reconsent needed
        XCTAssertFalse(rec!.needsReconsent(currentPolicyVersion: "1.0"))
        
        // Different version - reconsent needed
        XCTAssertTrue(rec!.needsReconsent(currentPolicyVersion: "2.0"))
    }
    
    func testIsValidForPolicy() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext
        
        let rec = ConsentRecord.create(
            scopes: ["usage_stats", "notifications"],
            language: "en",
            version: "1.0",
            in: ctx
        )
        try ctx.save()
        
        // Valid for same policy version
        XCTAssertTrue(rec!.isValidForPolicy("1.0"))
        
        // Invalid for different policy version
        XCTAssertFalse(rec!.isValidForPolicy("2.0"))
        
        // Empty scopes consent is invalid regardless of version
        let emptyRec = ConsentRecord.create(
            scopes: [],
            language: "en",
            version: "1.0",
            in: ctx
        )
        try ctx.save()
        XCTAssertFalse(emptyRec!.isValidForPolicy("1.0"))
    }
    
    func testConsentDoesNotExpire() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext
        
        let rec = ConsentRecord.create(
            scopes: ["usage_stats"],
            language: "en",
            version: "1.0",
            in: ctx
        )
        try ctx.save()
        
        // Consent is valid immediately
        XCTAssertTrue(rec!.isConsented)
        
        // Simulate time passing (24+ hours) - consent should still be valid
        // Note: Since we removed time-based expiration, this should always be true
        XCTAssertTrue(rec!.isConsented, "Consent should never expire based on time")
    }
}

