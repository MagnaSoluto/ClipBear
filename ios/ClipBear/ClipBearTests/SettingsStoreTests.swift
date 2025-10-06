import XCTest
@testable import ClipBear

final class SettingsStoreTests: XCTestCase {
    func testIntensityAndHardCap() {
        let s = SettingsStore()
        s.setIntensity("basic")
        XCTAssertEqual(s.maxSuggestionsPerDay, 2)
        s.setIntensity("proactive")
        XCTAssertEqual(s.maxSuggestionsPerDay, 5) // hard cap
    }

    func testSnoozeFlow() {
        let s = SettingsStore()
        s.setSnoozeUntil(Date().addingTimeInterval(3600))
        XCTAssertTrue(s.isSnoozed)
        s.setSnoozeUntil(Date().addingTimeInterval(-60))
        XCTAssertFalse(s.isSnoozed)
    }
    
    func testLanguageChange() {
        let s = SettingsStore()
        s.setLanguage("pt")
        XCTAssertEqual(s.language, "pt")
        s.setLanguage("en")
        XCTAssertEqual(s.language, "en")
    }
}

