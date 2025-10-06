import XCTest
@testable import ClipBearWidget

final class WidgetTimelineTests: XCTestCase {
    func testTimelineHasEntry() {
        let provider = Provider()
        let exp = expectation(description: "Timeline")
        provider.getTimeline(in: .init()) { timeline in
            XCTAssertFalse(timeline.entries.isEmpty)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 2.0)
    }
    
    func testWidgetEntryView() {
        let entry = SimpleEntry(date: Date(), suggestion: "Test suggestion")
        let view = ClipBearWidgetEntryView(entry: entry)
        XCTAssertNotNil(view)
    }
    
    func testWidgetWithSuggestion() {
        let entry = SimpleEntry(date: Date(), suggestion: "Take a break?")
        let view = ClipBearWidgetEntryView(entry: entry)
        XCTAssertNotNil(view)
    }
}

