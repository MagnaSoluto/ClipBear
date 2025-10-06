import XCTest

final class OnboardingUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-tests"]
        app.launch()
    }

    func testOnboardingFlow() {
        // Idioma EN/PT toggle
        if app.buttons["language.portuguese".localized].exists { 
            app.buttons["language.portuguese".localized].tap() 
        }
        if app.buttons["language.english".localized].exists { 
            app.buttons["language.english".localized].tap() 
        }

        // Next / Accept
        app.buttons["button.next".localized].firstMatch.tap()
        app.buttons["button.next".localized].firstMatch.tap()
        if app.buttons["Allow"].exists { app.buttons["Allow"].tap() } // caso tenha CTA
        app.buttons["I Accept"].firstMatch.tap()

        // Deve ir para a tela principal
        XCTAssertTrue(app.staticTexts["ClipBear"].exists)
    }
    
    func testLanguageToggle() {
        // Test language switching
        if app.buttons["language.portuguese".localized].exists {
            app.buttons["language.portuguese".localized].tap()
            // Verify Portuguese text appears
            XCTAssertTrue(app.staticTexts["onboarding.welcome.title".localized].exists)
        }
        
        if app.buttons["language.english".localized].exists {
            app.buttons["language.english".localized].tap()
            // Verify English text appears
            XCTAssertTrue(app.staticTexts["onboarding.welcome.title".localized].exists)
        }
    }
}

