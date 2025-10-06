import XCTest
@testable import ClipBear

final class LocalizationTests: XCTestCase {
    func testManualLanguageSwitch() {
        let lm = LocalizationManager.shared
        lm.setLanguage("pt")
        let pt = lm.localizedString("onboarding.welcome.title")
        lm.setLanguage("en")
        let en = lm.localizedString("onboarding.welcome.title")
        XCTAssertNotEqual(pt, en, "PT and EN strings should differ")
        XCTAssertFalse(pt.isEmpty)
        XCTAssertFalse(en.isEmpty)
    }
    
    func testStringExtension() {
        let lm = LocalizationManager.shared
        lm.setLanguage("en")
        let localized = "button.next".localized
        XCTAssertFalse(localized.isEmpty)
        XCTAssertNotEqual(localized, "button.next")
    }
    
    func testBundleLoading() {
        let lm = LocalizationManager.shared
        
        // Test English bundle
        lm.setLanguage("en")
        let enWelcome = lm.localizedString("onboarding.welcome.title")
        XCTAssertTrue(enWelcome.contains("Welcome"), "English bundle should load")
        
        // Test Portuguese bundle
        lm.setLanguage("pt")
        let ptWelcome = lm.localizedString("onboarding.welcome.title")
        XCTAssertTrue(ptWelcome.contains("Bem-vindo"), "Portuguese bundle should load")
        
        // Verify they're different
        XCTAssertNotEqual(enWelcome, ptWelcome, "Different languages should return different strings")
    }
    
    func testFallbackForInvalidKey() {
        let lm = LocalizationManager.shared
        lm.setLanguage("en")
        let invalid = lm.localizedString("invalid.key.does.not.exist")
        // Should return the key itself as fallback
        XCTAssertEqual(invalid, "invalid.key.does.not.exist")
    }
}

