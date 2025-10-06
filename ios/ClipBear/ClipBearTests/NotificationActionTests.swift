import XCTest
import CoreData
@testable import ClipBear

final class NotificationActionTests: XCTestCase {
    func testAcceptRejectActionsCreateFeedback() throws {
        let c = TestingCoreData.inMemoryContainer()
        let ctx = c.viewContext
        
        NotificationService.shared.handleAction(identifier: "ACCEPT_ACTION",
                                                ruleId: "demo.rule",
                                                context: ctx)
        
        let request: NSFetchRequest<SuggestionFeedback> = SuggestionFeedback.fetchRequest()
        let fr = try ctx.fetch(request)
        XCTAssertEqual(fr.count, 1)
        XCTAssertTrue(fr.first?.accepted ?? false)

        NotificationService.shared.handleAction(identifier: "REJECT_ACTION",
                                                ruleId: "demo.rule",
                                                context: ctx)
        
        let fr2 = try ctx.fetch(request)
        XCTAssertEqual(fr2.count, 2)
        XCTAssertFalse(fr2.last?.accepted ?? true)
    }
    
    func testInvalidActionDoesNothing() throws {
        let c = TestingCoreData.inMemoryContainer()
        let ctx = c.viewContext
        
        NotificationService.shared.handleAction(identifier: "INVALID_ACTION",
                                                ruleId: "demo.rule",
                                                context: ctx)
        
        let request: NSFetchRequest<SuggestionFeedback> = SuggestionFeedback.fetchRequest()
        let fr = try ctx.fetch(request)
        XCTAssertEqual(fr.count, 0)
    }
}

