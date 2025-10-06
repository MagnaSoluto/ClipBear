import XCTest
import CoreData
@testable import ClipBear

final class SuggestionModelTests: XCTestCase {
    func testSuggestionAcceptRejectAndExplainability() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext

        let s = Suggestion.create(
            ruleId: "screen_restlessness",
            message: "Take a short break?",
            explanation: "You opened the screen 5x in 10min",
            language: "en",
            sessionId: "test_session",
            in: ctx
        )
        XCTAssertFalse(s.isShown)
        s.markAsShown()
        XCTAssertTrue(s.isShown)
        XCTAssertFalse(s.isAccepted)

        s.markAsAccepted()
        XCTAssertTrue(s.isAccepted)

        XCTAssertFalse(s.explanation.isEmpty, "Explainability is required")
    }
    
    func testSuggestionRejection() throws {
        let container = TestingCoreData.inMemoryContainer()
        let ctx = container.viewContext

        let s = Suggestion.create(
            ruleId: "test_rule",
            message: "Test message",
            explanation: "Test explanation",
            language: "en",
            sessionId: "test_session",
            in: ctx
        )
        
        s.markAsRejected()
        XCTAssertFalse(s.isAccepted)
        XCTAssertNotNil(s.feedbackTimestamp)
    }
}

